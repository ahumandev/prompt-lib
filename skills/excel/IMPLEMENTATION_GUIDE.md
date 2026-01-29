# Excel Skill Implementation Guide

## Overview

The Excel skill has been successfully created and is ready for use. This guide explains how to use the skill, how it integrates with your Opencode setup, and best practices for Excel operations.

## Skill Location

```
~/.config/opencode/skills/excel-operations/
├── SKILL.md                                    # Main skill document
├── references/
│   ├── excel-tools-reference.md               # Complete API reference
│   ├── common-patterns.md                     # Real-world usage patterns
│   ├── data-handling.md                       # Data manipulation guide
│   └── cell-operations-guide.md               # Formatting and formula guide
└── assets/
    └── quick-reference.md                     # Quick lookup guide
```

## How to Use the Skill

### Step 1: Discover the Skill

When you need to work with Excel files, search for the skill:

```
skill_find "excel"
```

This will return the excel-operations skill with its description.

### Step 2: Load the Skill

Once discovered, load it into your chat context:

```
skill_use "excel_operations"
```

This makes all the skill's documentation available to the AI, including:
- Main SKILL.md with comprehensive guidance
- Reference documents for specific tool information
- Quick reference for common operations
- Example patterns for typical workflows

### Step 3: Use Excel Tools

With the skill loaded, you can instruct the AI to use Excel operations:

**Example**:
> "Load the excel_operations skill and create a new workbook at /tmp/sales.xlsx with a worksheet named 'Q1Data'. Then add headers 'Region', 'Sales', 'Cost' and write sample data for 4 regions."

The AI will:
1. Reference the skill's guidance
2. Determine the correct Excel tools to use
3. Execute the operations in the correct sequence
4. Return results with verification

### Step 4: Access Specific References

If you need specific information without loading the full skill:

```
skill_resource skill_name="excel_operations" relative_path="references/excel-tools-reference.md"
skill_resource skill_name="excel_operations" relative_path="assets/quick-reference.md"
skill_resource skill_name="excel_operations" relative_path="references/common-patterns.md"
```

## What's Included

### Main Skill Document (SKILL.md)

Comprehensive overview including:
- **When to use**: 8 key scenarios where Excel operations are needed
- **Key capabilities**: 5 main categories of operations
- **Important patterns**: 5 proven patterns for common tasks
- **Tool categories**: 6 categories with detailed descriptions
- **Reference documents**: Pointers to detailed guides
- **Quick start examples**: 4 working examples
- **Error handling**: Common issues and solutions
- **Workflow examples**: 3 end-to-end workflows
- **Performance notes**: Optimization tips
- **Security notes**: Safe operation guidelines

### Reference Documents

#### 1. **excel-tools-reference.md**
Complete API reference for all 26 Excel tools:
- **File Operations** (6 tools): Create, read, write, get metadata, copy, delete
- **Worksheet Operations** (4 tools): Create, rename, copy, delete
- **Cell Formatting** (4 tools): Format ranges, merge, unmerge, get merged
- **Cell Operations** (2 tools): Apply formula, validate formula
- **Tables and Ranges** (7 tools): Create table, validate range, insert/delete rows/columns
- **Advanced Features** (3 tools): Charts, pivot tables, data validation

Each tool includes:
- Purpose description
- Parameter definitions
- Return value documentation
- Working examples
- Common errors and solutions
- Best practices

#### 2. **common-patterns.md**
9 real-world patterns for typical Excel workflows:
1. Data import pipeline
2. Report generation with formatting
3. Data validation setup
4. Multi-sheet reports
5. Efficient batch processing
6. Template-based reports
7. Data cleanup and standardization
8. Dashboard with charts
9. Conditional formatting

Each pattern includes:
- Scenario description
- Step-by-step workflow
- Tools used
- Complete example code
- Anti-patterns (what NOT to do)

#### 3. **data-handling.md**
Best practices for working with data:
- **Reading data**: Preview mode, specific ranges, large files, metadata
- **Writing data**: Batch operations, specific locations, append vs replace
- **Transforming data**: Cleaning pipeline, standardization, validation
- **Data types**: Number formatting, text alignment, multi-line text
- **Aggregated data**: Summaries, pivot tables
- **Data validation**: Validation rules, quality checks
- **Performance tips**: 5 optimization strategies

#### 4. **cell-operations-guide.md**
Comprehensive cell formatting and formula guide:
- **Formatting fundamentals**: All format parameters, basic formatting
- **Colors**: Named colors, hex color reference
- **Text alignment**: Horizontal and vertical alignment
- **Borders**: Border styles and colors
- **Number formatting**: Currency, percentage, thousands separator, decimals, dates, times
- **Merging cells**: Merging, unmerging, checking merged cells
- **Formula operations**: Basic formulas, validation, common functions, cross-sheet formulas, copying formulas
- **Practical examples**: Professional header, alternating rows

#### 5. **quick-reference.md**
Quick lookup for frequent operations:
- Most common operations with syntax
- Number format cheat sheet
- Common formula reference
- Color hex codes
- Workflow checklists

### Asset Files

**quick-reference.md**: Fast reference guide (in assets directory for easy access)

## Integration with Opencode

### How It Works

1. **Skill Discovery**: Agents can find the skill using `skill_find "excel"`
2. **Lazy Loading**: Skill is only loaded when explicitly requested with `skill_use "excel_operations"`
3. **Exclusive Access**: Excel MCP server is available through the skill, not directly to other agents
4. **Context Injection**: When loaded, the skill provides all documentation and guidance

### Configuration

The skill works with your existing Opencode configuration:

```json
// ~/.config/opencode/opencode.jsonc
{
  "mcp": {
    "excel": {
      "type": "local",
      "command": ["/home/me/excel-mcp-server/.venv/bin/excel-mcp-server", "stdio"]
    }
    // ... other MCPs
  },
  "plugin": [
    // ... other plugins
    "@zenobius/opencode-skillful",  // Enables skill system
    // ... other plugins
  ]
}
```

The Excel MCP server is available in opencode.jsonc and is used by agents when they load this skill.

## Usage Examples

### Example 1: Create a Sales Report

```
Task: Create a professional sales report for Q1 2025

Steps:
1. skill_find "excel"
2. skill_use "excel_operations"
3. "Create a new workbook at ~/Q1_Report.xlsx with:
   - Title row (merged, centered, blue background): 'Q1 2025 Sales Report'
   - Headers: Region | Sales | Cost | Profit | Margin %
   - Data for 4 regions with sample numbers
   - Format headers with bold and gray background
   - Add totals row with formulas
   - Format currency columns as $#,##0.00
   - Format margin column as 0.00%
   - Add a bar chart showing sales by region"
```

The AI will:
- Load the excel_operations skill
- Reference the SKILL.md for comprehensive guidance
- Check excel-tools-reference.md for specific tool parameters
- Review common-patterns.md for report generation pattern
- Execute the operations correctly
- Verify formatting and calculations

### Example 2: Import and Clean Data

```
Task: Import customer data and clean it

Steps:
1. skill_find "excel"
2. skill_use "excel_operations"
3. "I have customer data with messy formatting. Please:
   - Create a workbook at ~/customers.xlsx
   - Create 'Raw' sheet and import this data
   - Create 'Clean' sheet
   - In Clean sheet, add formulas to:
     * TRIM and UPPER all names (from Raw!A:A)
     * Validate email format (check for @ symbol)
     * Convert phone numbers to standard format
     * Extract year from date fields
   - Create 'Summary' sheet with counts and statistics"
```

The AI will:
- Reference data-handling.md for cleaning patterns
- Review common-patterns.md pattern #7 (data cleanup)
- Apply appropriate formulas
- Set up proper structure

### Example 3: Create Dashboard

```
Task: Create an interactive dashboard

Steps:
1. skill_find "excel"
2. skill_use "excel_operations"
3. "Create a sales dashboard with:
   - Summary metrics at top (Total Sales, Avg Deal Size, Growth %)
   - Line chart showing sales trend over 12 months
   - Pie chart showing sales by region
   - Table with top 10 customers
   - Conditional formatting highlighting targets vs actual"
```

The AI will:
- Reference common-patterns.md pattern #8 (dashboard with charts)
- Use excel-create-chart for visualizations
- Apply formatting and metrics
- Create professional layout

## Best Practices

### When to Use This Skill

Use the Excel skill when you need to:
- Create new Excel files programmatically
- Manipulate existing workbooks
- Apply formulas and calculations
- Create visualizations (charts, pivot tables)
- Import/export data
- Format reports professionally
- Automate Excel workflows

### Workflow Recommendations

**For Data Import**:
1. Load skill
2. Create structure (workbook, sheets)
3. Write raw data
4. Preview to verify
5. Add transformation formulas
6. Review cleaned data

**For Report Generation**:
1. Load skill
2. Check common-patterns.md for similar pattern
3. Create workbook structure
4. Add headers and data
5. Apply formatting
6. Add formulas for calculations
7. Create visualizations
8. Verify and save

**For Data Analysis**:
1. Load skill
2. Read source data (with preview first)
3. Create analysis sheet
4. Add calculated columns
5. Create pivot table for summary
6. Add charts for visualization
7. Add insights/notes

### Performance Optimization

From data-handling.md:
1. **Batch operations**: Write all data in one call, not row-by-row
2. **Efficient formulas**: Use formulas instead of hardcoded calculations
3. **Specific ranges**: Don't read entire files if you know the range
4. **Format after data**: Format ranges after writing data
5. **Reuse templates**: Use worksheet copy for similar structures

### File Paths

Always use absolute paths:

**Good**:
```
filepath="/home/user/reports/Q1_2025.xlsx"
filepath="/tmp/analysis.xlsx"
filepath="/home/user/data/import.xlsx"
```

**Avoid**:
```
filepath="report.xlsx"           # Relative path
filepath="~/report.xlsx"         # May not expand properly
filepath="./data/report.xlsx"   # Relative to current directory
```

## Troubleshooting

### Issue: "Formula syntax validation fails"

**Solution**: 
1. Check formula carefully for typos
2. Ensure formula starts with `=`
3. Use `excel_validate_formula_syntax` before applying
4. Test with simpler formula first
5. Reference excel-tools-reference.md for syntax

**Example**:
```
# Validate first
excel_validate_formula_syntax(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=SUM(B2:D2)"
)

# Then apply if valid
excel_apply_formula(...)
```

### Issue: "Cell range out of bounds"

**Solution**:
1. Use preview mode to check actual data range
2. Verify start_cell and end_cell are correct
3. Use `excel_validate_excel_range` to validate
4. Check sheet name spelling

### Issue: "Merged cells prevent operation"

**Solution**:
1. Check for merged cells with `excel_get_merged_cells`
2. Unmerge cells before operation
3. Then remerge if needed after

### Issue: "Data truncated or formatting lost"

**Solution**:
1. Use batch operations instead of individual cells
2. Apply formatting after writing data
3. Use `excel_read_data_from_excel` to verify structure
4. Check for validation metadata that needs preserving

## Resources and Documentation

### In This Skill

- `SKILL.md` - Start here for overview
- `references/excel-tools-reference.md` - Tool-by-tool reference
- `references/common-patterns.md` - Real-world patterns
- `references/data-handling.md` - Data best practices
- `references/cell-operations-guide.md` - Formatting and formulas
- `assets/quick-reference.md` - Quick lookup

### External

- Excel MCP Server: `/home/me/excel-mcp-server/`
- Opencode Skillful: `@zenobius/opencode-skillful`
- Opencode Docs: `https://opencode.ai/docs/`

## Next Steps

1. **Learn the basics**: Read SKILL.md for comprehensive overview
2. **Pick a workflow**: Find matching pattern in common-patterns.md
3. **Load the skill**: Use `skill_use "excel_operations"` in your chat
4. **Start small**: Try a simple operation first
5. **Explore references**: Dive into specific guides as needed
6. **Build complexity**: Combine multiple operations

## Support and Updates

The skill is designed to be comprehensive and self-contained. If you encounter:

- **New Excel operations**: Check excel-tools-reference.md for all available tools
- **Similar workflows**: Check common-patterns.md for examples
- **Data issues**: Reference data-handling.md for best practices
- **Formatting questions**: See cell-operations-guide.md
- **Quick lookups**: Use quick-reference.md

---

**Implementation Guide Version**: 1.0
**Created**: 2025-01-28
**Status**: Complete and Ready for Use
