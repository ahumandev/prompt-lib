# Data Handling Guide

Best practices for reading, writing, and transforming data in Excel.

## Reading Data Effectively

### Understanding Preview Mode

Preview mode is your first step when working with unknown Excel files:

```
excel_read_data_from_excel(
  filepath="/unknown-file.xlsx",
  sheet_name="Data",
  preview_only=true  # ← Returns sample only
)
```

**Benefits of preview**:
- See what data structure looks like
- Check for empty rows/columns
- Identify headers and data ranges
- Determine if data needs cleaning
- Estimate total data size

### Reading Specific Ranges

Once you understand the structure, read specific ranges:

```
# Read from A1 to E100 (avoiding empty areas)
excel_read_data_from_excel(
  filepath="/data.xlsx",
  sheet_name="Sales",
  start_cell="A1",
  end_cell="E100",
  preview_only=false
)
```

**Why specify ranges?**
- Avoids reading empty cells
- Faster for large files
- Cleaner data without noise
- Better memory efficiency

### Handling Large Files

For files with thousands of rows:

```
# Read in chunks if very large
# First chunk
excel_read_data_from_excel(
  filepath="/huge-file.xlsx",
  sheet_name="Data",
  start_cell="A1",
  end_cell="Z1000",
  preview_only=false
)

# Next chunk
excel_read_data_from_excel(
  filepath="/huge-file.xlsx",
  sheet_name="Data",
  start_cell="A1001",
  end_cell="Z2000",
  preview_only=false
)
```

**Or use preview to see full extent**:
```
excel_read_data_from_excel(
  filepath="/huge-file.xlsx",
  sheet_name="Data",
  preview_only=true  # Shows sample, tells total rows
)
```

### Extracting Metadata

Data often includes validation rules and formatting info:

```
# Read includes metadata
data = excel_read_data_from_excel(
  filepath="/form.xlsx",
  sheet_name="Entries",
  start_cell="A1",
  end_cell="D100",
  preview_only=false
)

# Each cell includes:
# - address: "A1"
# - value: actual cell content
# - row: row number
# - column: column number
# - validation: any validation rules (if present)
```

---

## Writing Data Efficiently

### Batch Writing (Single Operation)

Always write all data at once, not row-by-row:

```
# Prepare all data first
data = [
  ["Name", "Age", "Department"],
  ["Alice", 30, "Sales"],
  ["Bob", 28, "Engineering"],
  ["Carol", 35, "Management"],
  ... more rows ...
]

# Write in one operation
excel_write_data_to_excel(
  filepath="/employees.xlsx",
  sheet_name="Staff",
  data=data,
  start_cell="A1"
)
```

**Performance impact**:
- Single operation: Few milliseconds
- Row-by-row loop: Potentially seconds

### Writing to Specific Locations

Write data starting at any position:

```
# Write summary starting at row 15
summary_data = [
  ["TOTAL:", 125000, 0.12]
]

excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Report",
  data=summary_data,
  start_cell="A15"  # Not from A1
)
```

### Appending vs Replacing

```
# Replace (overwrites): Start from beginning
excel_write_data_to_excel(
  filepath="/data.xlsx",
  sheet_name="Data",
  data=new_data,
  start_cell="A1"  # Overwrites from A1
)

# Append (adds after existing): Start after data
excel_write_data_to_excel(
  filepath="/data.xlsx",
  sheet_name="Data",
  data=new_rows,
  start_cell="A1001"  # After existing data
)
```

---

## Transforming Data

### Cleaning Data Pipeline

Typical flow for messy imported data:

1. **Import to Raw Sheet**
```
excel_write_data_to_excel(
  filepath="/import.xlsx",
  sheet_name="Raw",
  data=imported_data,
  start_cell="A1"
)
```

2. **Create Clean Sheet**
```
excel_create_worksheet(filepath="/import.xlsx", sheet_name="Clean")
```

3. **Add Transformation Formulas**
```
# Clean up text in column A
excel_apply_formula(
  filepath="/import.xlsx",
  sheet_name="Clean",
  cell="A2",
  formula="=UPPER(TRIM(Raw!A2))"
)

# Convert text to number in column B
excel_apply_formula(
  filepath="/import.xlsx",
  sheet_name="Clean",
  cell="B2",
  formula="=VALUE(Raw!B2)"
)

# Format date in column C
excel_apply_formula(
  filepath="/import.xlsx",
  sheet_name="Clean",
  cell="C2",
  formula="=DATE(YEAR(Raw!C2), MONTH(Raw!C2), DAY(Raw!C2))"
)
```

4. **Copy Formulas Down**
```
excel_copy_range(
  filepath="/import.xlsx",
  sheet_name="Clean",
  source_start="A2",
  source_end="C2",
  target_start="A3"
)
```

5. **Review Results**
```
excel_read_data_from_excel(
  filepath="/import.xlsx",
  sheet_name="Clean",
  start_cell="A1",
  end_cell="C100",
  preview_only=false
)
```

### Standardizing Values

Common standardization needs:

**Uppercase all text**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Clean",
  cell="A2",
  formula="=UPPER(Raw!A2)"
)
```

**Remove leading/trailing spaces**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Clean",
  cell="A2",
  formula="=TRIM(Raw!A2)"
)
```

**Combine multiple fields**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Clean",
  cell="A2",
  formula="=CONCATENATE(Raw!B2, \", \", Raw!C2, \" - \", Raw!D2)"
)
```

**Parse text fields**:
```
# Extract first word
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Clean",
  cell="A2",
  formula="=LEFT(Raw!A2, FIND(\" \", Raw!A2)-1)"
)
```

### Validation and Checking

**Find missing values**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="QA",
  cell="D2",
  formula="=IF(ISBLANK(Raw!A2), \"MISSING\", \"OK\")"
)
```

**Check for duplicates**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="QA",
  cell="E2",
  formula="=COUNTIF(Raw$A$2:Raw$A$1000, Raw!A2)>1"
)
```

**Validate range of values**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="QA",
  cell="F2",
  formula="=IF(AND(Raw!B2>=0, Raw!B2<=100), \"OK\", \"OUT_OF_RANGE\")"
)
```

---

## Data Types and Formatting

### Number Formatting

Numbers should be formatted appropriately:

**Currency**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Financial",
  start_cell="B2",
  end_cell="B1000",
  number_format="$#,##0.00"
)
```

**Percentage**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="C2",
  end_cell="C1000",
  number_format="0.00%"
)
```

**Thousands separator**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  number_format="#,##0"
)
```

**Dates**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  number_format="MM/DD/YYYY"
)
```

**Scientific notation**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  number_format="0.00E+00"
)
```

### Text Alignment

Right-align numbers, left-align text:

```
# Headers centered
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A1",
  end_cell="D1",
  alignment="center"
)

# Data rows with appropriate alignment
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  alignment="left"  # Text
)

excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  alignment="right"  # Numbers
)
```

### Multi-line Text

Enable text wrapping for long content:

```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Notes",
  start_cell="C2",
  end_cell="C1000",
  wrap_text=true
)
```

---

## Working with Aggregated Data

### Creating Summaries

Common aggregation functions:

**Sum**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B10",
  formula="=SUM(Data!B2:B9)"
)
```

**Average**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B11",
  formula="=AVERAGE(Data!B2:B9)"
)
```

**Count non-empty**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B12",
  formula="=COUNTA(Data!A2:A9)"
)
```

**Count numbers**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B13",
  formula="=COUNT(Data!B2:B9)"
)
```

**Min/Max**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B14",
  formula="=MIN(Data!B2:B9)"
)

excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B15",
  formula="=MAX(Data!B2:B9)"
)
```

### Using Pivot Tables

For more complex grouping:

```
excel_create_pivot_table(
  filepath="/data.xlsx",
  sheet_name="Raw",
  data_range="A1:D1000",
  rows=["Department", "Manager"],
  columns=["Month"],
  values=["Sales", "Cost"],
  agg_func="sum"
)
```

This creates a pivot table grouped by Department and Manager, with months as columns, showing sum of Sales and Cost.

---

## Data Validation

### Setting up Validation Rules

Create dropdown lists:

```
# Create list of valid values
excel_write_data_to_excel(
  filepath="/form.xlsx",
  sheet_name="Lists",
  data=[
    ["Departments"],
    ["Sales"],
    ["Engineering"],
    ["HR"],
    ["Finance"]
  ],
  start_cell="A1"
)

# Get validation info
validation_info = excel_get_data_validation_info(
  filepath="/form.xlsx",
  sheet_name="Entries"
)
```

### Quality Checks

Before data processing:

```
# Check for required fields
excel_apply_formula(
  filepath="/validation.xlsx",
  sheet_name="QA",
  cell="E2",
  formula="=IF(ISBLANK(Raw!A2), \"ERROR: Missing ID\", \"OK\")"
)

# Check format
excel_apply_formula(
  filepath="/validation.xlsx",
  sheet_name="QA",
  cell="E3",
  formula="=IF(ISNUMBER(Raw!B2), \"OK\", \"ERROR: Not a number\")"
)

# Check range
excel_apply_formula(
  filepath="/validation.xlsx",
  sheet_name="QA",
  cell="E4",
  formula="=IF(AND(Raw!C2>=1, Raw!C2<=12), \"OK\", \"ERROR: Month out of range\")"
)
```

---

## Performance Tips

1. **Batch operations**: Write all data in one call
2. **Efficient formulas**: Use array formulas when possible
3. **Specific ranges**: Don't read entire files if you know the range
4. **Format after data**: Format ranges after writing data
5. **Reuse templates**: Use worksheet copy for similar structures
6. **Minimize file operations**: Do all edits in sequence, not reopening

---

**Data Handling Guide Version**: 1.0
**Last Updated**: 2025-01-28
