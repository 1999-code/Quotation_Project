import datetime
from django.db import models

class Quotation(models.Model):
    document_type = models.CharField(max_length=50, default="Quotation")
    quotation_no = models.CharField(max_length=100, unique=True)
    issued_date = models.DateField(null=True, blank=True)
    valid_until = models.DateField(null=True, blank=True)
    project_location = models.CharField(max_length=255, blank=True)
    currency = models.CharField(max_length=10, default="INR")
    project_name = models.CharField(max_length=255, blank=True)
    project_type = models.CharField(max_length=255, blank=True, default="Website")

    # Business Details
    business_name = models.CharField(max_length=255, default="KENSTACK TECHNOLOGIES PRIVATE LIMITED")
    business_email = models.EmailField(blank=True)
    business_phone = models.CharField(max_length=50, blank=True)
    business_gst = models.CharField(max_length=100, blank=True, default="33AAMCK6128J1ZB")
    business_website = models.CharField(max_length=255, blank=True)
    business_address = models.TextField(blank=True)

    # Client Details
    client_name = models.CharField(max_length=255)
    company_name = models.CharField(max_length=255, blank=True)
    client_email = models.EmailField(blank=True)
    client_phone = models.CharField(max_length=50, blank=True)
    client_gst = models.CharField(max_length=100, blank=True)
    client_address = models.TextField(blank=True)

    # Amounts & Taxes
    enable_gst = models.BooleanField(default=True)
    subtotal = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    cgst = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    sgst = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    discount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    tax = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    total_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    paid_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    balance_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)

    # Extra Details
    note_message = models.TextField(blank=True)
    terms_conditions = models.TextField(blank=True)
    bank_name = models.CharField(max_length=255, blank=True, default="Karur Vysya Bank")
    account_holder = models.CharField(max_length=255, blank=True, default="KENSTACK TECHNOLOGIES PRIVATE LIMITED")
    account_number = models.CharField(max_length=255, blank=True, default="1602010000000351")
    ifsc = models.CharField(max_length=100, blank=True, default="KVBL0001602")
    branch = models.CharField(max_length=255, blank=True, default="Trichy Gundur Branch")

    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, null=True, blank=True)

    @property
    def display_title(self):
        dt = (self.document_type or "Quotation").strip()
        if "QUOTATION" in dt.upper():
            return dt.upper()
        return f"{dt.upper()} QUOTATION"

    @property
    def formatted_business_address(self):
        addr = (self.business_address or "").strip()
        if not addr:
            addr = "2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023"
        if "Tiruchirappalli (Trichy)," in addr and "Tamil Nadu" in addr and "<br>" not in addr and "\n" not in addr:
            addr = addr.replace("Tiruchirappalli (Trichy),", "Tiruchirappalli (Trichy),<br>")
        return addr

    @property
    def terms_conditions_list(self):
        text = self.terms_conditions
        if not text or not text.strip():
            text = "50% advance required to start the project.\nRemaining payment before final delivery.\nAdditional features will be charged separately."
        import re
        lines = [line.strip() for line in text.split('\n') if line.strip()]
        return [re.sub(r'^\d+[\.\)\-]\s*', '', line) for line in lines]

    def __str__(self):
        return self.quotation_no


class QuotationItem(models.Model):
    quotation = models.ForeignKey(Quotation, related_name='items', on_delete=models.CASCADE)
    item_name = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    quantity = models.IntegerField(default=1)
    unit_price = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)

    def __str__(self):
        return f"{self.item_name} ({self.quotation.quotation_no})"


class Invoice(models.Model):
    document_type = models.CharField(max_length=50, default="Invoice")
    invoice_number = models.CharField(max_length=100, unique=True)
    quotation = models.OneToOneField(Quotation, related_name='invoice', on_delete=models.CASCADE)
    customer = models.CharField(max_length=255)
    invoice_date = models.DateField(null=True, blank=True)
    valid_until = models.DateField(null=True, blank=True)
    project_location = models.CharField(max_length=255, blank=True)
    currency = models.CharField(max_length=10, default="INR")
    project_name = models.CharField(max_length=255, blank=True)
    project_type = models.CharField(max_length=255, blank=True, default="Website")

    # Business Details
    business_name = models.CharField(max_length=255, default="KENSTACK TECHNOLOGIES PRIVATE LIMITED")
    business_email = models.EmailField(blank=True)
    business_phone = models.CharField(max_length=50, blank=True)
    business_gst = models.CharField(max_length=100, blank=True, default="33AAMCK6128J1ZB")
    business_website = models.CharField(max_length=255, blank=True)
    business_address = models.TextField(blank=True)

    # Client Details
    client_name = models.CharField(max_length=255, blank=True)
    company_name = models.CharField(max_length=255, blank=True)
    client_email = models.EmailField(blank=True)
    client_phone = models.CharField(max_length=50, blank=True)
    client_gst = models.CharField(max_length=100, blank=True)
    client_address = models.TextField(blank=True)

    # Amounts & Taxes
    enable_gst = models.BooleanField(default=True)
    subtotal = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    cgst = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    sgst = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    discount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    tax = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    total_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    paid_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    balance_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)

    # Extra Details
    note_message = models.TextField(blank=True)
    terms_conditions = models.TextField(blank=True)
    bank_name = models.CharField(max_length=255, blank=True, default="Karur Vysya Bank")
    account_holder = models.CharField(max_length=255, blank=True, default="KENSTACK TECHNOLOGIES PRIVATE LIMITED")
    account_number = models.CharField(max_length=255, blank=True, default="1602010000000351")
    ifsc = models.CharField(max_length=100, blank=True, default="KVBL0001602")
    branch = models.CharField(max_length=255, blank=True, default="Trichy Gundur Branch")

    status = models.CharField(max_length=50, default='Unpaid')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    @property
    def display_title(self):
        dt = (self.document_type or "Invoice").strip()
        dt_upper = dt.upper()
        if "INVOICE" in dt_upper:
            return dt_upper
        elif "QUOTATION" in dt_upper:
            clean = dt_upper.replace("QUOTATION", "").strip()
            return f"{clean} INVOICE".strip() if clean else "INVOICE"
        else:
            return f"{dt_upper} INVOICE"

    @property
    def formatted_business_address(self):
        addr = (self.business_address or "").strip()
        if not addr and self.quotation:
            addr = (self.quotation.business_address or "").strip()
        if not addr:
            addr = "2/3, Samadh School Street, Kaja Nagar, Edamalaipatti Pudur, Tiruchirappalli (Trichy), Tamil Nadu, 620023"
        if "Tiruchirappalli (Trichy)," in addr and "Tamil Nadu" in addr and "<br>" not in addr and "\n" not in addr:
            addr = addr.replace("Tiruchirappalli (Trichy),", "Tiruchirappalli (Trichy),<br>")
        return addr

    @property
    def terms_conditions_list(self):
        text = self.terms_conditions or (self.quotation.terms_conditions if self.quotation else "")
        if not text or not text.strip():
            text = "50% advance required to start the project.\nRemaining payment before final delivery.\nAdditional features will be charged separately."
        import re
        lines = [line.strip() for line in text.split('\n') if line.strip()]
        return [re.sub(r'^\d+[\.\)\-]\s*', '', line) for line in lines]

    def __str__(self):
        return self.invoice_number


class InvoiceItem(models.Model):
    invoice = models.ForeignKey(Invoice, related_name='items', on_delete=models.CASCADE)
    item_name = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    quantity = models.IntegerField(default=1)
    unit_price = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)

    def __str__(self):
        return f"{self.item_name} ({self.invoice.invoice_number})"