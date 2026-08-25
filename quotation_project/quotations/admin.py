from django.contrib import admin
from .models import Quotation, QuotationItem, Invoice, InvoiceItem

class QuotationItemInline(admin.TabularInline):
    model = QuotationItem
    extra = 0

@admin.register(Quotation)
class QuotationAdmin(admin.ModelAdmin):
    list_display = ('quotation_no', 'client_name', 'document_type', 'total_amount', 'issued_date', 'valid_until')
    list_filter = ('document_type', 'issued_date', 'valid_until')
    search_fields = ('quotation_no', 'client_name', 'company_name', 'project_name')
    inlines = [QuotationItemInline]

class InvoiceItemInline(admin.TabularInline):
    model = InvoiceItem
    extra = 0

@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = ('invoice_number', 'customer', 'total_amount', 'paid_amount', 'balance_amount', 'status', 'invoice_date')
    list_filter = ('status', 'invoice_date')
    search_fields = ('invoice_number', 'customer')
    inlines = [InvoiceItemInline]
