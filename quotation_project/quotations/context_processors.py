from .models import Quotation, Invoice

def project_category_context(request):
    selected_category = request.GET.get('category', '').strip()
    
    standard_types = [
        'Website',
        'Website with Admin Panel',
        'CRM',
        'Office Automation',
        'Billing System',
        'AI Software',
        'E-commerce'
    ]

    q_types = list(Quotation.objects.values_list('project_type', flat=True).distinct())
    i_types = list(Invoice.objects.values_list('project_type', flat=True).distinct())
    
    raw_types = standard_types + [t.strip() for t in q_types if t and t.strip()] + [t.strip() for t in i_types if t and t.strip()]
    
    all_types = []
    seen = set()
    for t in raw_types:
        if t.lower() not in seen:
            seen.add(t.lower())
            all_types.append(t)

    cat_counts = {}
    categories_list = []
    
    for st in all_types:
        c_q = Quotation.objects.filter(project_type__iexact=st).count()
        c_i = Invoice.objects.filter(project_type__iexact=st).count()
        tot = c_q + c_i
        key_name = st.replace(' ', '_').replace('-', '_')
        cat_counts[key_name] = tot
        categories_list.append({
            'name': st,
            'slug': key_name,
            'count': tot
        })

    total_q = Quotation.objects.count()
    total_i = Invoice.objects.count()
    total_count = total_q + total_i

    if selected_category:
        active_q_count = Quotation.objects.filter(project_type__iexact=selected_category).count()
        active_i_count = Invoice.objects.filter(project_type__iexact=selected_category).count()
        active_category_count = active_q_count + active_i_count
    else:
        active_q_count = total_q
        active_i_count = total_i
        active_category_count = total_count

    return {
        'selected_category': selected_category,
        'cat_counts': cat_counts,
        'all_categories': all_types,
        'categories_list': categories_list,
        'total_count': total_count,
        'total_q_count': total_q,
        'total_i_count': total_i,
        'active_category_count': active_category_count,
        'active_q_count': active_q_count,
        'active_i_count': active_i_count,
    }

