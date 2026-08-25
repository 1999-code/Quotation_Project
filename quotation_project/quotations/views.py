import datetime
from decimal import Decimal
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone
from django.db import models, transaction
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from .models import Quotation, QuotationItem, Invoice, InvoiceItem

def parse_date(date_str):
    if not date_str or not str(date_str).strip():
        return None
    s = str(date_str).strip()
    for fmt in ('%Y-%m-%d', '%d-%m-%Y', '%d/%m/%Y', '%Y/%m/%d'):
        try:
            return datetime.datetime.strptime(s, fmt).date()
        except ValueError:
            pass
    return None

def parse_decimal(val_str, default=0.0):
    try:
        return Decimal(str(val_str).strip())
    except (ValueError, TypeError, Exception):
        return Decimal(str(default))

def generate_invoice_number(quotation_no):
    if "QUT" in quotation_no:
        return quotation_no.replace("QUT", "INV")
    elif "QUO" in quotation_no:
        return quotation_no.replace("QUO", "INV")
    elif "QT" in quotation_no:
        return quotation_no.replace("QT", "INV")
    else:
        return f"INV-{quotation_no}"

@never_cache
def user_login(request):
    if request.user.is_authenticated:
        return redirect('quotation_create')
        
    error_message = None
    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '').strip()
        
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            next_url = request.POST.get('next') or request.GET.get('next') or 'quotation_create'
            return redirect(next_url)
        else:
            error_message = "Invalid username or password. Please try again."

    return render(request, 'quotations/login.html', {'error_message': error_message})

@never_cache
def user_logout(request):
    logout(request)
    return redirect('login')

@never_cache
@login_required(login_url='login')
def quotation_create(request):
    if request.method == 'POST':
        document_type = request.POST.get('document_type', 'Quotation')
        quotation_no = request.POST.get('quotation_no', '').strip()
        issued_date_str = request.POST.get('issued_date', '')
        valid_until_str = request.POST.get('valid_until', '')
        project_location = request.POST.get('project_location', '')
        currency = request.POST.get('currency', 'INR')
        project_name = request.POST.get('project_name', '')
        
        custom_proj = request.POST.get('custom_project_type', '').strip()
        select_proj = request.POST.get('project_type_select', '').strip() or request.POST.get('project_type', '').strip()
        project_type = custom_proj if custom_proj else (select_proj or "Website")

        business_name = request.POST.get('business_name', 'KENSTACK TECHNOLOGIES PRIVATE LIMITED')
        business_email = request.POST.get('business_email', '')
        business_phone = request.POST.get('business_phone', '')
        business_gst = request.POST.get('business_gst', '').strip() or '33AAMCK6128J1ZB'
        business_website = request.POST.get('business_website', '')
        business_address = request.POST.get('business_address', '')
        
        client_name = request.POST.get('client_name', 'Valued Client')
        company_name = request.POST.get('company_name', '')
        client_email = request.POST.get('client_email', '')
        client_phone = request.POST.get('client_phone', '')
        client_gst = request.POST.get('client_gst', '')
        client_address = request.POST.get('client_address', '')

        note_message = request.POST.get('custom_message', '')
        terms_conditions = request.POST.get('terms', '')
        bank_name = request.POST.get('bank_name', 'Karur Vysya Bank')
        account_holder = request.POST.get('account_holder', 'KENSTACK TECHNOLOGIES PRIVATE LIMITED')
        account_number = request.POST.get('account_number', '1602010000000351')
        ifsc = request.POST.get('ifsc', 'KVBL0001602')
        branch = request.POST.get('branch', 'Trichy Gundur Branch')

        if not quotation_no:
            quotation_no = f"KS/QUT/{timezone.now().strftime('%Y-%y')}/{Quotation.objects.count() + 1:04d}"

        existing_q = Quotation.objects.filter(quotation_no=quotation_no).first()

        services = request.POST.getlist('service')
        descriptions = request.POST.getlist('description')
        qtys = request.POST.getlist('qty')
        rates = request.POST.getlist('rate')

        subtotal = Decimal('0.00')

        with transaction.atomic():
            if existing_q:
                quotation = existing_q
                quotation.document_type = document_type
                quotation.issued_date = parse_date(issued_date_str)
                quotation.valid_until = parse_date(valid_until_str)
                quotation.project_location = project_location
                quotation.currency = currency
                quotation.project_name = project_name
                quotation.project_type = project_type
                quotation.business_name = business_name
                quotation.business_email = business_email
                quotation.business_phone = business_phone
                quotation.business_gst = business_gst
                quotation.business_website = business_website
                quotation.business_address = business_address
                quotation.client_name = client_name
                quotation.company_name = company_name
                quotation.client_email = client_email
                quotation.client_phone = client_phone
                quotation.client_gst = client_gst
                quotation.client_address = client_address
                quotation.note_message = note_message
                quotation.terms_conditions = terms_conditions
                quotation.bank_name = bank_name
                quotation.account_holder = account_holder
                quotation.account_number = account_number
                quotation.ifsc = ifsc
                quotation.branch = branch
                quotation.items.all().delete()
            else:
                quotation = Quotation.objects.create(
                    document_type=document_type,
                    quotation_no=quotation_no,
                    issued_date=parse_date(issued_date_str),
                    valid_until=parse_date(valid_until_str),
                    project_location=project_location,
                    currency=currency,
                    project_name=project_name,
                    project_type=project_type,
                    business_name=business_name,
                    business_email=business_email,
                    business_phone=business_phone,
                    business_gst=business_gst,
                    business_website=business_website,
                    business_address=business_address,
                    client_name=client_name,
                    company_name=company_name,
                    client_email=client_email,
                    client_phone=client_phone,
                    client_gst=client_gst,
                    client_address=client_address,
                    note_message=note_message,
                    terms_conditions=terms_conditions,
                    bank_name=bank_name,
                    account_holder=account_holder,
                    account_number=account_number,
                    ifsc=ifsc,
                    branch=branch,
                )

            for i in range(len(services)):
                item_name = services[i].strip() if i < len(services) else ""
                desc = descriptions[i].strip() if i < len(descriptions) else ""
                q_val = qtys[i] if i < len(qtys) else "1"
                q = int(q_val) if q_val and str(q_val).isdigit() else 1
                r = parse_decimal(rates[i]) if i < len(rates) else Decimal('0.00')
                amt = Decimal(q) * r

                if item_name or amt > 0:
                    QuotationItem.objects.create(
                        quotation=quotation,
                        item_name=item_name or "Service Item",
                        description=desc,
                        quantity=q,
                        unit_price=r,
                        amount=amt
                    )
                    subtotal += amt

            enable_gst = ('enable_gst' in request.POST)
            if enable_gst:
                cgst = subtotal * Decimal('0.09')
                sgst = subtotal * Decimal('0.09')
                total_amount = subtotal + cgst + sgst
            else:
                cgst = Decimal('0.00')
                sgst = Decimal('0.00')
                total_amount = subtotal
            balance_amount = total_amount

            quotation.enable_gst = enable_gst
            quotation.subtotal = subtotal
            quotation.cgst = cgst
            quotation.sgst = sgst
            quotation.tax = cgst + sgst
            quotation.total_amount = total_amount
            quotation.balance_amount = balance_amount
            quotation.save()

        return redirect('quotation_detail', pk=quotation.pk)

    previous_quotation_nos = list(Quotation.objects.values_list('quotation_no', flat=True).order_by('-id'))
    return render(request, 'quotations/quotation_create.html', {
        'previous_quotation_nos': previous_quotation_nos
    })

@never_cache
@login_required(login_url='login')
def quotation_edit(request, pk):
    quotation = get_object_or_404(Quotation.objects.prefetch_related('items'), pk=pk)

    if request.method == 'POST':
        document_type = request.POST.get('document_type', quotation.document_type)
        quotation_no = request.POST.get('quotation_no', quotation.quotation_no).strip()
        issued_date_str = request.POST.get('issued_date', '')
        valid_until_str = request.POST.get('valid_until', '')
        project_location = request.POST.get('project_location', '')
        currency = request.POST.get('currency', 'INR')
        project_name = request.POST.get('project_name', '')

        custom_proj = request.POST.get('custom_project_type', '').strip()
        select_proj = request.POST.get('project_type_select', '').strip() or request.POST.get('project_type', '').strip()
        project_type = custom_proj if custom_proj else (select_proj or quotation.project_type or "Website")

        business_name = request.POST.get('business_name', quotation.business_name)
        business_email = request.POST.get('business_email', quotation.business_email)
        business_phone = request.POST.get('business_phone', quotation.business_phone)
        business_gst = request.POST.get('business_gst', '').strip() or quotation.business_gst or '33AAMCK6128J1ZB'
        business_website = request.POST.get('business_website', quotation.business_website)
        business_address = request.POST.get('business_address', quotation.business_address)
        
        client_name = request.POST.get('client_name', quotation.client_name)
        company_name = request.POST.get('company_name', quotation.company_name)
        client_email = request.POST.get('client_email', quotation.client_email)
        client_phone = request.POST.get('client_phone', quotation.client_phone)
        client_gst = request.POST.get('client_gst', quotation.client_gst)
        client_address = request.POST.get('client_address', quotation.client_address)

        note_message = request.POST.get('custom_message', quotation.note_message)
        terms_conditions = request.POST.get('terms', quotation.terms_conditions)
        bank_name = request.POST.get('bank_name', quotation.bank_name)
        account_holder = request.POST.get('account_holder', quotation.account_holder)
        account_number = request.POST.get('account_number', quotation.account_number)
        ifsc = request.POST.get('ifsc', quotation.ifsc)
        branch = request.POST.get('branch', quotation.branch)

        services = request.POST.getlist('service')
        descriptions = request.POST.getlist('description')
        qtys = request.POST.getlist('qty')
        rates = request.POST.getlist('rate')

        subtotal = Decimal('0.00')

        with transaction.atomic():
            quotation.document_type = document_type
            quotation.quotation_no = quotation_no
            
            # Explicit Date Updating
            if issued_date_str:
                quotation.issued_date = parse_date(issued_date_str)
            if valid_until_str:
                quotation.valid_until = parse_date(valid_until_str)

            quotation.project_location = project_location
            quotation.currency = currency
            quotation.project_name = project_name
            quotation.project_type = project_type
            quotation.business_name = business_name
            quotation.business_email = business_email
            quotation.business_phone = business_phone
            quotation.business_gst = business_gst
            quotation.business_website = business_website
            quotation.business_address = business_address
            quotation.client_name = client_name
            quotation.company_name = company_name
            quotation.client_email = client_email
            quotation.client_phone = client_phone
            quotation.client_gst = client_gst
            quotation.client_address = client_address

            quotation.note_message = note_message
            quotation.terms_conditions = terms_conditions
            quotation.bank_name = bank_name
            quotation.account_holder = account_holder
            quotation.account_number = account_number
            quotation.ifsc = ifsc
            quotation.branch = branch

            # Re-create line items
            quotation.items.all().delete()

            for i in range(len(services)):
                item_name = services[i].strip() if i < len(services) else ""
                desc = descriptions[i].strip() if i < len(descriptions) else ""
                q_val = qtys[i] if i < len(qtys) else "1"
                q = int(q_val) if q_val and str(q_val).isdigit() else 1
                r = parse_decimal(rates[i]) if i < len(rates) else Decimal('0.00')
                amt = Decimal(q) * r

                if item_name or amt > 0:
                    QuotationItem.objects.create(
                        quotation=quotation,
                        item_name=item_name or "Service Item",
                        description=desc,
                        quantity=q,
                        unit_price=r,
                        amount=amt
                    )
                    subtotal += amt

            enable_gst = ('enable_gst' in request.POST)
            if enable_gst:
                cgst = subtotal * Decimal('0.09')
                sgst = subtotal * Decimal('0.09')
                total_amount = subtotal + cgst + sgst
            else:
                cgst = Decimal('0.00')
                sgst = Decimal('0.00')
                total_amount = subtotal
            balance_amount = total_amount - quotation.paid_amount

            quotation.enable_gst = enable_gst
            quotation.subtotal = subtotal
            quotation.cgst = cgst
            quotation.sgst = sgst
            quotation.tax = cgst + sgst
            quotation.total_amount = total_amount
            quotation.balance_amount = balance_amount
            quotation.save()

            if hasattr(quotation, 'invoice'):
                inv = quotation.invoice
                inv.document_type = "Invoice"
                inv.invoice_number = generate_invoice_number(quotation.quotation_no)
                inv.customer = quotation.client_name
                inv.valid_until = quotation.valid_until
                inv.project_location = quotation.project_location
                inv.currency = quotation.currency
                inv.project_name = quotation.project_name
                inv.project_type = quotation.project_type
                inv.business_name = quotation.business_name
                inv.business_email = quotation.business_email
                inv.business_phone = quotation.business_phone
                inv.business_gst = quotation.business_gst
                inv.business_website = quotation.business_website
                inv.business_address = quotation.business_address
                inv.client_name = quotation.client_name
                inv.company_name = quotation.company_name
                inv.client_email = quotation.client_email
                inv.client_phone = quotation.client_phone
                inv.client_gst = quotation.client_gst
                inv.client_address = quotation.client_address
                inv.enable_gst = enable_gst
                inv.subtotal = subtotal
                inv.cgst = cgst
                inv.sgst = sgst
                inv.tax = cgst + sgst
                inv.total_amount = total_amount
                inv.balance_amount = total_amount - inv.paid_amount
                inv.note_message = quotation.note_message
                inv.terms_conditions = quotation.terms_conditions
                inv.bank_name = quotation.bank_name
                inv.account_holder = quotation.account_holder
                inv.account_number = quotation.account_number
                inv.ifsc = quotation.ifsc
                inv.branch = quotation.branch
                inv.save()

                inv.items.all().delete()
                for q_item in quotation.items.all():
                    InvoiceItem.objects.create(
                        invoice=inv,
                        item_name=q_item.item_name,
                        description=q_item.description,
                        quantity=q_item.quantity,
                        unit_price=q_item.unit_price,
                        amount=q_item.amount
                    )

        return redirect('quotation_detail', pk=quotation.pk)

    previous_quotation_nos = list(Quotation.objects.values_list('quotation_no', flat=True).order_by('-id'))
    return render(request, 'quotations/quotation_edit.html', {
        'quotation': quotation,
        'previous_quotation_nos': previous_quotation_nos
    })

@never_cache
@login_required(login_url='login')
def quotation_delete(request, pk):
    quotation = get_object_or_404(Quotation, pk=pk)
    if request.method == 'POST':
        quotation.delete()
    return redirect('quotation_list')

@never_cache
@login_required(login_url='login')
def quotation_list(request):
    category = request.GET.get('category', '').strip()
    search_query = request.GET.get('search', '').strip()
    from_date_str = request.GET.get('from_date', '').strip()
    to_date_str = request.GET.get('to_date', '').strip()

    quotations = Quotation.objects.all().order_by('-id')

    if category:
        quotations = quotations.filter(project_type__iexact=category)

    if search_query:
        quotations = quotations.filter(
            models.Q(quotation_no__icontains=search_query) |
            models.Q(client_name__icontains=search_query) |
            models.Q(company_name__icontains=search_query) |
            models.Q(project_name__icontains=search_query)
        )

    from_date = parse_date(from_date_str)
    if from_date:
        quotations = quotations.filter(issued_date__gte=from_date)

    to_date = parse_date(to_date_str)
    if to_date:
        quotations = quotations.filter(issued_date__lte=to_date)

    return render(request, 'quotations/quotation_list.html', {
        'quotations': quotations,
        'category_filter': category,
        'search_query': search_query,
        'from_date': from_date_str,
        'to_date': to_date_str,
    })

@never_cache
@login_required(login_url='login')
def quotation_detail(request, pk):
    quotation = get_object_or_404(Quotation.objects.prefetch_related('items'), pk=pk)
    return render(request, 'quotations/quotation_detail.html', {'quotation': quotation})

@never_cache
@login_required(login_url='login')
def quotation_invoice(request, pk):
    quotation = get_object_or_404(Quotation.objects.prefetch_related('items'), pk=pk)

    items = quotation.items.all()
    subtotal = sum(item.amount for item in items) if items.exists() else quotation.subtotal

    if quotation.enable_gst:
        cgst = quotation.cgst if quotation.cgst > 0 else (subtotal * Decimal('0.09'))
        sgst = quotation.sgst if quotation.sgst > 0 else (subtotal * Decimal('0.09'))
    else:
        cgst = Decimal('0.00')
        sgst = Decimal('0.00')
    discount = quotation.discount
    tax = cgst + sgst
    total_amount = quotation.total_amount if quotation.total_amount > 0 else (subtotal - discount + tax)
    paid_amount = quotation.paid_amount
    balance_amount = total_amount - paid_amount

    if balance_amount <= 0 and total_amount > 0:
        status = 'Paid'
    elif paid_amount > 0:
        status = 'Partially Paid'
    else:
        status = 'Unpaid'

    invoice_number = generate_invoice_number(quotation.quotation_no)

    with transaction.atomic():
        if hasattr(quotation, 'invoice'):
            invoice = quotation.invoice
            invoice.document_type = quotation.document_type
            invoice.invoice_number = invoice_number
            invoice.customer = quotation.client_name
            invoice.invoice_date = quotation.issued_date
            invoice.valid_until = quotation.valid_until
            invoice.project_location = quotation.project_location
            invoice.currency = quotation.currency
            invoice.project_name = quotation.project_name
            invoice.project_type = quotation.project_type
            invoice.business_name = quotation.business_name
            invoice.business_email = quotation.business_email
            invoice.business_phone = quotation.business_phone
            invoice.business_gst = quotation.business_gst
            invoice.business_website = quotation.business_website
            invoice.business_address = quotation.business_address
            invoice.client_name = quotation.client_name
            invoice.company_name = quotation.company_name
            invoice.client_email = quotation.client_email
            invoice.client_phone = quotation.client_phone
            invoice.client_gst = quotation.client_gst
            invoice.client_address = quotation.client_address
            invoice.enable_gst = quotation.enable_gst
            invoice.subtotal = subtotal
            invoice.cgst = cgst
            invoice.sgst = sgst
            invoice.discount = discount
            invoice.tax = tax
            invoice.total_amount = total_amount
            invoice.paid_amount = paid_amount
            invoice.balance_amount = balance_amount
            invoice.note_message = quotation.note_message
            invoice.terms_conditions = quotation.terms_conditions
            invoice.bank_name = quotation.bank_name
            invoice.account_holder = quotation.account_holder
            invoice.account_number = quotation.account_number
            invoice.ifsc = quotation.ifsc
            invoice.branch = quotation.branch
            invoice.status = status
            invoice.save()

            invoice.items.all().delete()
            for q_item in items:
                InvoiceItem.objects.create(
                    invoice=invoice,
                    item_name=q_item.item_name,
                    description=q_item.description,
                    quantity=q_item.quantity,
                    unit_price=q_item.unit_price,
                    amount=q_item.amount
                )
        else:
            invoice = Invoice.objects.create(
                quotation=quotation,
                document_type=quotation.document_type,
                invoice_number=invoice_number,
                customer=quotation.client_name,
                invoice_date=quotation.issued_date,
                valid_until=quotation.valid_until,
                project_location=quotation.project_location,
                currency=quotation.currency,
                project_name=quotation.project_name,
                project_type=quotation.project_type,
                business_name=quotation.business_name,
                business_email=quotation.business_email,
                business_phone=quotation.business_phone,
                business_gst=quotation.business_gst,
                business_website=quotation.business_website,
                business_address=quotation.business_address,
                client_name=quotation.client_name,
                company_name=quotation.company_name,
                client_email=quotation.client_email,
                client_phone=quotation.client_phone,
                client_gst=quotation.client_gst,
                client_address=quotation.client_address,
                enable_gst=quotation.enable_gst,
                subtotal=subtotal,
                cgst=cgst,
                sgst=sgst,
                discount=discount,
                tax=tax,
                total_amount=total_amount,
                paid_amount=paid_amount,
                balance_amount=balance_amount,
                note_message=quotation.note_message,
                terms_conditions=quotation.terms_conditions,
                bank_name=quotation.bank_name,
                account_holder=quotation.account_holder,
                account_number=quotation.account_number,
                ifsc=quotation.ifsc,
                branch=quotation.branch,
                status=status
            )

            for q_item in items:
                InvoiceItem.objects.create(
                    invoice=invoice,
                    item_name=q_item.item_name,
                    description=q_item.description,
                    quantity=q_item.quantity,
                    unit_price=q_item.unit_price,
                    amount=q_item.amount
                )

    return redirect('invoice_detail', pk=invoice.pk)

def sync_invoice_data(invoice):
    if not invoice or not invoice.quotation:
        return
    
    q = invoice.quotation
    expected_inv_no = generate_invoice_number(q.quotation_no)
    need_save = False
    
    if invoice.invoice_number != expected_inv_no:
        invoice.invoice_number = expected_inv_no
        need_save = True

    fields_to_sync = [
        ('document_type', q.document_type),
        ('invoice_date', q.issued_date),
        ('customer', q.client_name),
        ('client_name', q.client_name),
        ('company_name', q.company_name),
        ('client_email', q.client_email),
        ('client_phone', q.client_phone),
        ('client_gst', q.client_gst),
        ('client_address', q.client_address),
        ('valid_until', q.valid_until),
        ('project_location', q.project_location),
        ('currency', q.currency),
        ('project_name', q.project_name),
        ('project_type', q.project_type),
        ('business_name', q.business_name),
        ('business_email', q.business_email),
        ('business_phone', q.business_phone),
        ('business_gst', q.business_gst),
        ('business_website', q.business_website),
        ('business_address', q.business_address),
        ('note_message', q.note_message),
        ('terms_conditions', q.terms_conditions),
        ('bank_name', q.bank_name),
        ('account_holder', q.account_holder),
        ('account_number', q.account_number),
        ('ifsc', q.ifsc),
        ('branch', q.branch),
        ('enable_gst', q.enable_gst),
    ]

    for field_name, value in fields_to_sync:
        if getattr(invoice, field_name) != value:
            setattr(invoice, field_name, value)
            need_save = True

    if not invoice.items.exists() and q.items.exists():
        subtotal = Decimal('0.00')
        for q_item in q.items.all():
            InvoiceItem.objects.create(
                invoice=invoice,
                item_name=q_item.item_name,
                description=q_item.description,
                quantity=q_item.quantity,
                unit_price=q_item.unit_price,
                amount=q_item.amount
            )
            subtotal += q_item.amount

        if q.enable_gst:
            cgst = q.cgst if q.cgst > 0 else (subtotal * Decimal('0.09'))
            sgst = q.sgst if q.sgst > 0 else (subtotal * Decimal('0.09'))
        else:
            cgst = Decimal('0.00')
            sgst = Decimal('0.00')
        total_amount = q.total_amount if q.total_amount > 0 else (subtotal + cgst + sgst)

        invoice.subtotal = subtotal
        invoice.cgst = cgst
        invoice.sgst = sgst
        invoice.tax = cgst + sgst
        invoice.total_amount = total_amount
        invoice.balance_amount = total_amount - invoice.paid_amount
        need_save = True

    if need_save:
        invoice.save()

@never_cache
@login_required(login_url='login')
def invoice_detail(request, pk):
    invoice = get_object_or_404(Invoice.objects.prefetch_related('items', 'quotation'), pk=pk)
    sync_invoice_data(invoice)
    return render(request, 'quotations/invoice_detail.html', {'invoice': invoice})

@never_cache
@login_required(login_url='login')
def invoice_pdf(request, pk):
    invoice = get_object_or_404(Invoice.objects.prefetch_related('items', 'quotation'), pk=pk)
    sync_invoice_data(invoice)
    return render(request, 'quotations/invoice_detail.html', {
        'invoice': invoice,
        'auto_download_pdf': True
    })

@never_cache
@login_required(login_url='login')
def invoice_delete(request, pk):
    invoice = get_object_or_404(Invoice, pk=pk)
    if request.method == 'POST':
        invoice.delete()
    return redirect('invoice_list')

@never_cache
@login_required(login_url='login')
def invoice_toggle_status(request, pk):
    invoice = get_object_or_404(Invoice, pk=pk)
    if request.method == 'POST':
        if invoice.status == 'Paid':
            invoice.status = 'Unpaid'
            invoice.paid_amount = Decimal('0.00')
            invoice.balance_amount = invoice.total_amount
        else:
            invoice.status = 'Paid'
            invoice.paid_amount = invoice.total_amount
            invoice.balance_amount = Decimal('0.00')
        invoice.save()
    referer = request.META.get('HTTP_REFERER')
    if referer:
        return redirect(referer)
    return redirect('invoice_list')

@never_cache
@login_required(login_url='login')
def invoice_list(request):
    category = request.GET.get('category', '').strip()
    search_query = request.GET.get('search', '').strip()
    from_date_str = request.GET.get('from_date', '').strip()
    to_date_str = request.GET.get('to_date', '').strip()

    invoices = Invoice.objects.select_related('quotation').order_by('-created_at', '-id')

    if category:
        invoices = invoices.filter(project_type__iexact=category)

    if search_query:
        invoices = invoices.filter(
            models.Q(invoice_number__icontains=search_query) |
            models.Q(quotation__quotation_no__icontains=search_query) |
            models.Q(customer__icontains=search_query) |
            models.Q(company_name__icontains=search_query) |
            models.Q(project_name__icontains=search_query)
        )

    from_date = parse_date(from_date_str)
    if from_date:
        invoices = invoices.filter(
            models.Q(invoice_date__gte=from_date) |
            models.Q(quotation__issued_date__gte=from_date)
        )

    to_date = parse_date(to_date_str)
    if to_date:
        invoices = invoices.filter(
            models.Q(invoice_date__lte=to_date) |
            models.Q(quotation__issued_date__lte=to_date)
        )

    for invoice in invoices:
        sync_invoice_data(invoice)

    return render(request, 'quotations/invoice_list.html', {
        'invoices': invoices,
        'category_filter': category,
        'search_query': search_query,
        'from_date': from_date_str,
        'to_date': to_date_str,
    })
