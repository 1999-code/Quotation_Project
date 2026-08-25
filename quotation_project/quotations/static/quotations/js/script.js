const addRowBtn = document.getElementById("addRow");
const tableBody = document.querySelector("#itemTable tbody");

// ==========================
// Add Item
// ==========================

if (addRowBtn) {
    addRowBtn.addEventListener("click", function () {
        const row = document.createElement("tr");
        row.innerHTML = `
        <td>
            <input type="text" class="form-control service" name="service" placeholder="Service">
        </td>
        <td>
            <input type="text" class="form-control description" name="description" placeholder="Description">
        </td>
        <td>
            <input type="number" class="form-control qty text-center" name="qty" value="1" min="1">
        </td>
        <td>
            <input type="number" class="form-control rate text-end" name="rate" value="0" min="0">
        </td>
        <td>
            <input type="text" class="form-control amount text-end" name="amount" value="0.00" readonly>
        </td>
        <td class="no-print">
            <button type="button" class="btn btn-danger btn-sm deleteRow no-print">
                <i class="bi bi-trash3-fill"></i>
            </button>
        </td>
        `;
        tableBody.appendChild(row);
        calculateTotal();
    });
}

// ==========================
// Delete Row
// ==========================

document.addEventListener("click", function (e) {
    if (e.target.closest(".deleteRow")) {
        if (tableBody && tableBody.rows.length > 1) {
            e.target.closest("tr").remove();
            calculateTotal();
        }
    }
});

// ==========================
// Qty × Rate
// ==========================

document.addEventListener("input", function (e) {
    if (
        e.target.classList.contains("qty") ||
        e.target.classList.contains("rate")
    ) {
        calculateTotal();
    }
});

// ==========================
// Summary Calculation
// ==========================

function calculateTotal() {
    let subtotal = 0;

    document.querySelectorAll("#itemTable tbody tr").forEach(function (row) {
        let qty = parseFloat(row.querySelector(".qty").value) || 0;
        let rate = parseFloat(row.querySelector(".rate").value) || 0;
        let amount = qty * rate;

        row.querySelector(".amount").value = amount.toFixed(2);
        subtotal += amount;
    });

    const gstToggle = document.getElementById("gstToggle");
    const enableGst = gstToggle ? gstToggle.checked : true;

    let cgst = enableGst ? (subtotal * 0.09) : 0;
    let sgst = enableGst ? (subtotal * 0.09) : 0;
    let grandTotal = subtotal + cgst + sgst;

    if (document.getElementById("subtotalAmount")) {
        document.getElementById("subtotalAmount").value = subtotal.toFixed(2);
    }

    const cgstRow = document.getElementById("cgstRow");
    const sgstRow = document.getElementById("sgstRow");

    if (cgstRow) {
        if (enableGst) {
            cgstRow.style.setProperty("display", "table-row", "important");
        } else {
            cgstRow.style.setProperty("display", "none", "important");
        }
    }
    if (sgstRow) {
        if (enableGst) {
            sgstRow.style.setProperty("display", "table-row", "important");
        } else {
            sgstRow.style.setProperty("display", "none", "important");
        }
    }

    if (document.getElementById("cgstAmount")) {
        document.getElementById("cgstAmount").value = cgst.toFixed(2);
    }

    if (document.getElementById("sgstAmount")) {
        document.getElementById("sgstAmount").value = sgst.toFixed(2);
    }

    if (document.getElementById("grandTotalAmount")) {
        document.getElementById("grandTotalAmount").value = grandTotal.toFixed(2);
    }
}

document.addEventListener("change", function (e) {
    if (e.target && e.target.id === "gstToggle") {
        calculateTotal();
    }
});

document.addEventListener("DOMContentLoaded", function () {
    if (document.getElementById("gstToggle")) {
        calculateTotal();
    }
});

// ==========================
// Add Message Button
// ==========================

const addMessageBtn = document.getElementById("addMessageBtn");
const removeMessageBtn = document.getElementById("removeMessageBtn");

if (addMessageBtn) {
    addMessageBtn.addEventListener("click", function () {
        const msgContainer = document.getElementById("messageContainer");
        const msgInput = document.getElementById("customMessageInput");
        if (msgContainer) {
            msgContainer.style.display = "block";
            if (msgInput) {
                msgInput.focus();
            }
        }
    });
}

if (removeMessageBtn) {
    removeMessageBtn.addEventListener("click", function () {
        const msgContainer = document.getElementById("messageContainer");
        const msgInput = document.getElementById("customMessageInput");
        if (msgContainer) {
            msgContainer.style.display = "none";
        }
        if (msgInput) {
            msgInput.value = "";
        }
    });
}

// ==========================
// Cancel Button
// ==========================

const cancelBtn = document.querySelector(".btn-outline-secondary");

if (cancelBtn) {
    cancelBtn.addEventListener("click", function () {
        if (confirm("Are you sure you want to clear the quotation?")) {
            location.reload();
        }
    });
}

// ==========================
// Initial Calculation
// ==========================

if (document.getElementById("itemTable")) {
    calculateTotal();
}

// ==========================
// Direct PDF Generation using html2pdf.js with Page Splitting
// ==========================

function openCreateQuotationPrint() {
    console.log("Triggering Create Quotation Print...");

    // ================= Business Details =================
    if (document.getElementById("pdfBusinessName") && document.getElementById("businessName"))
        document.getElementById("pdfBusinessName").textContent = document.getElementById("businessName").value;

    if (document.getElementById("pdfBusinessEmail") && document.getElementById("businessEmail"))
        document.getElementById("pdfBusinessEmail").textContent = document.getElementById("businessEmail").value;

    if (document.getElementById("pdfBusinessPhone") && document.getElementById("businessPhone"))
        document.getElementById("pdfBusinessPhone").textContent = document.getElementById("businessPhone").value;

    if (document.getElementById("pdfBusinessGST") && document.getElementById("businessGST")) {
        const bgst = (document.getElementById("businessGST").value || "").trim();
        document.getElementById("pdfBusinessGST").textContent = (bgst && bgst !== "---") ? bgst : "33AAMCK6128J1ZB";
    }

    if (document.getElementById("pdfBusinessWebsite") && document.getElementById("businessWebsite"))
        document.getElementById("pdfBusinessWebsite").textContent = document.getElementById("businessWebsite").value;

    if (document.getElementById("pdfBusinessAddress") && document.getElementById("businessAddress"))
        document.getElementById("pdfBusinessAddress").textContent = document.getElementById("businessAddress").value;

    // ================= Client Details =================
    if (document.getElementById("pdfClientName") && document.getElementById("clientName"))
        document.getElementById("pdfClientName").textContent = document.getElementById("clientName").value;

    if (document.getElementById("pdfCompanyName") && document.getElementById("companyName"))
        document.getElementById("pdfCompanyName").textContent = document.getElementById("companyName").value;

    if (document.getElementById("pdfClientEmail") && document.getElementById("clientEmail"))
        document.getElementById("pdfClientEmail").textContent = document.getElementById("clientEmail").value;

    if (document.getElementById("pdfClientPhone") && document.getElementById("clientPhone"))
        document.getElementById("pdfClientPhone").textContent = document.getElementById("clientPhone").value;

    if (document.getElementById("pdfClientGST") && document.getElementById("clientGST"))
        document.getElementById("pdfClientGST").textContent = document.getElementById("clientGST").value;

    if (document.getElementById("pdfClientAddress") && document.getElementById("clientAddress"))
        document.getElementById("pdfClientAddress").textContent = document.getElementById("clientAddress").value;

    if (document.getElementById("pdfLocation") && document.getElementById("projectLocation"))
        document.getElementById("pdfLocation").textContent = document.getElementById("projectLocation").value;

    if (document.getElementById("pdfDocumentType") && document.getElementById("documentType")) {
        const rawDocType = (document.getElementById("documentType").value || "").trim().toUpperCase();
        if (rawDocType.includes("QUOTATION")) {
            document.getElementById("pdfDocumentType").textContent = rawDocType;
        } else {
            document.getElementById("pdfDocumentType").textContent = rawDocType ? `${rawDocType} QUOTATION` : "QUOTATION";
        }
    }

    if (document.getElementById("pdfQuoteNo") && document.getElementById("quotationNo"))
        document.getElementById("pdfQuoteNo").textContent = document.getElementById("quotationNo").value;

    if (document.getElementById("pdfQuoteDate") && document.getElementById("issueDate"))
        document.getElementById("pdfQuoteDate").textContent = document.getElementById("issueDate").value;

    if (document.getElementById("pdfValidUntil") && document.getElementById("validUntil"))
        document.getElementById("pdfValidUntil").textContent = document.getElementById("validUntil").value;

    if (document.getElementById("pdfProjectName") && document.getElementById("projectName"))
        document.getElementById("pdfProjectName").textContent = document.getElementById("projectName").value;

    // ================= Bank Details =================
    if (document.getElementById("pdfBankName") && document.getElementById("bankName"))
        document.getElementById("pdfBankName").textContent = document.getElementById("bankName").value;

    if (document.getElementById("pdfAccountHolder") && document.getElementById("accountHolder"))
        document.getElementById("pdfAccountHolder").textContent = document.getElementById("accountHolder").value;

    if (document.getElementById("pdfAccountNumber") && document.getElementById("accountNumber"))
        document.getElementById("pdfAccountNumber").textContent = document.getElementById("accountNumber").value;

    if (document.getElementById("pdfIFSC") && document.getElementById("ifsc"))
        document.getElementById("pdfIFSC").textContent = document.getElementById("ifsc").value;

    if (document.getElementById("pdfBranch") && document.getElementById("branch"))
        document.getElementById("pdfBranch").textContent = document.getElementById("branch").value;

    function getCurrencySymbol(currency) {
        const symbols = {
            INR: "₹",
            USD: "$",
            AED: "AED ",
        };
        return symbols[currency] || "";
    }

    const defaultTerms = `
<li>50% advance required to start the project.</li>
<li>Remaining payment before final delivery.</li>
<li>Additional features will be charged separately.</li>
`;

    const termsEl = document.getElementById("terms");
    const terms = termsEl ? termsEl.value.trim() : "";
    let html = "";

    if (terms !== "") {
        const termsArray = terms.split("\n");
        termsArray.forEach(function (term) {
            if (term.trim() !== "") {
                html += `<li>${term.trim()}</li>`;
            }
        });
    } else {
        html = defaultTerms;
    }

    if (document.getElementById("pdfTerms"))
        document.getElementById("pdfTerms").innerHTML = html;

    // ================= Custom Message =================
    const msgInput = document.getElementById("customMessageInput");
    const pdfMsgRow = document.getElementById("pdfMessageRow");
    const pdfMsgTxt = document.getElementById("pdfMessageText");
    const msgContainer = document.getElementById("messageContainer");

    const msgVal = msgInput ? msgInput.value.trim() : "";
    const isMsgContainerVisible = msgContainer ? msgContainer.style.display !== "none" : true;

    if (msgVal !== "" && isMsgContainerVisible) {
        if (pdfMsgTxt) pdfMsgTxt.textContent = msgVal;
        if (pdfMsgRow) pdfMsgRow.style.display = "table-row";
    } else {
        if (pdfMsgRow) pdfMsgRow.style.display = "none";
    }

    const currencyEl = document.getElementById("currency");
    const currency = currencyEl ? currencyEl.value : "INR";
    const symbol = getCurrencySymbol(currency);
    const pdfBody = document.getElementById("pdfServiceBody");

    if (pdfBody) {
        pdfBody.innerHTML = "";
        document.querySelectorAll("#itemTable tbody tr").forEach(function (row) {
            let sEl = row.querySelector(".service");
            let dEl = row.querySelector(".description");
            let qEl = row.querySelector(".qty");
            let rEl = row.querySelector(".rate");

            let sVal = sEl ? sEl.value : "";
            let dVal = dEl ? dEl.value : "";
            let qVal = qEl ? (parseFloat(qEl.value) || 0) : 0;
            let rVal = rEl ? (parseFloat(rEl.value) || 0) : 0;
            let amount = qVal * rVal;

            if (sVal || amount > 0) {
                pdfBody.innerHTML += `
                <tr>
                    <td>${sVal}</td>
                    <td>${dVal}</td>
                    <td>${qVal}</td>
                    <td>${symbol}${rVal.toFixed(2)}</td>
                    <td>${symbol}${amount.toFixed(2)}</td>
                </tr>
                `;
            }
        });
    }

    const gstToggle = document.getElementById("gstToggle");
    const enableGst = gstToggle ? gstToggle.checked : true;

    let subtotal = parseFloat(document.getElementById("subtotalAmount") ? document.getElementById("subtotalAmount").value : 0) || 0;
    let cgst = enableGst ? (subtotal * 0.09) : 0;
    let sgst = enableGst ? (subtotal * 0.09) : 0;
    let grandTotal = subtotal + cgst + sgst;

    const pdfCgstRow = document.getElementById("pdfCgstRow");
    const pdfSgstRow = document.getElementById("pdfSgstRow");

    if (pdfCgstRow) {
        if (enableGst) {
            pdfCgstRow.style.setProperty("display", "table-row", "important");
        } else {
            pdfCgstRow.style.setProperty("display", "none", "important");
        }
    }
    if (pdfSgstRow) {
        if (enableGst) {
            pdfSgstRow.style.setProperty("display", "table-row", "important");
        } else {
            pdfSgstRow.style.setProperty("display", "none", "important");
        }
    }

    if (document.getElementById("pdfSubtotal")) {
        document.getElementById("pdfSubtotal").textContent = symbol + subtotal.toFixed(2);
    }

    if (document.getElementById("pdfCgst")) {
        document.getElementById("pdfCgst").textContent = symbol + cgst.toFixed(2);
    }

    if (document.getElementById("pdfSgst")) {
        document.getElementById("pdfSgst").textContent = symbol + sgst.toFixed(2);
    }

    if (document.getElementById("pdfGrandTotal")) {
        document.getElementById("pdfGrandTotal").textContent = symbol + grandTotal.toFixed(2);
    }

    const createTemplate = document.getElementById("createQuotationPrintTemplate") || document.getElementById("printTemplate");
    const formSection = document.getElementById("formSection");

    if (formSection) formSection.style.display = "none";
    if (createTemplate) createTemplate.style.display = "block";
    window.print();
    if (formSection) formSection.style.display = "block";
    if (createTemplate) createTemplate.style.display = "none";
}

window.openCreateQuotationPrint = openCreateQuotationPrint;

const downloadPdfBtn = document.getElementById("downloadPdf");
if (downloadPdfBtn) {
    downloadPdfBtn.addEventListener("click", openCreateQuotationPrint);
}
