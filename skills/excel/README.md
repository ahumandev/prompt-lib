# Excel Operations Skill for Opencode

Complete Excel MCP Server skill for Opencode with comprehensive documentation, patterns, and best practices.

## Quick Start

### Discover the Skill
```
skill_find "excel"
```

### Load the Skill
```
skill_use "excel_operations"
```

### Use Excel Tools
Ask the AI to help with Excel operations:
```
"Create a new workbook at /tmp/sales.xlsx with quarterly sales data and a bar chart"
```

## What's Included

This skill provides:
- **Complete API Reference**: All 26 Excel tools documented with examples
- **9 Real-World Patterns**: Data import, reports, dashboards, cleanup, etc.
- **Best Practices Guide**: Data handling, formatting, formulas
- **Quick Reference**: Cheat sheets for formats, formulas, colors
- **Implementation Guide**: How to use and integrate

## Files

| File | Purpose | Size |
|------|---------|------|
| **SKILL.md** | Main skill document with overview | 450+ lines |
| **IMPLEMENTATION_GUIDE.md** | How to use and integrate | 400+ lines |
| **references/excel-tools-reference.md** | API reference for 26 tools | 800+ lines |
| **references/common-patterns.md** | 9 real-world patterns | 900+ lines |
| **references/data-handling.md** | Data best practices | 400+ lines |
| **references/cell-operations-guide.md** | Formatting and formulas | 600+ lines |
| **assets/quick-reference.md** | Quick lookup cheat sheet | 300+ lines |

**Total**: 3,389 lines of comprehensive documentation

## Features

✅ **26 Excel Tools Documented**
- File operations
- Worksheet operations  
- Cell formatting
- Formula operations
- Tables and ranges
- Charts and pivot tables

✅ **9 Real-World Patterns**
1. Data import pipeline
2. Report generation
3. Data validation
4. Multi-sheet reports
5. Batch processing
6. Template-based reports
7. Data cleanup
8. Dashboards
9. Conditional formatting

✅ **Best Practices**
- Reading and writing data efficiently
- Data transformation and cleaning
- Professional formatting
- Formula creation and validation
- Performance optimization

✅ **Security**
- Exclusive access through skill interface
- Lazy-loaded (only consume tokens when needed)
- Controlled through skill system

## Learning Path

1. **Start**: Read SKILL.md for overview
2. **Quick Lookup**: Check quick-reference.md
3. **Common Workflow**: Find matching pattern in common-patterns.md
4. **Detailed Reference**: Use specific guides as needed
5. **Integration**: Review IMPLEMENTATION_GUIDE.md

## Usage Examples

### Example 1: Create a Report
```
1. skill_find "excel"
2. skill_use "excel_operations"
3. "Create a Q1 sales report with:
   - Title and headers
   - Data for 4 regions
   - Totals with formulas
   - Professional formatting
   - Bar chart"
```

### Example 2: Import and Clean Data
```
1. skill_find "excel"
2. skill_use "excel_operations"
3. "Import this customer data, clean it by:
   - Removing extra spaces
   - Standardizing format
   - Validating required fields"
```

### Example 3: Create Dashboard
```
1. skill_find "excel"
2. skill_use "excel_operations"
3. "Create a dashboard with:
   - Summary metrics
   - Sales trends chart
   - Top customers table
   - Conditional highlighting"
```

## Tools Reference

### File Operations (6 tools)
- Create workbook
- Read data
- Write data
- Get metadata
- Copy range
- Delete range

### Worksheet Operations (4 tools)
- Create worksheet
- Rename worksheet
- Copy worksheet
- Delete worksheet

### Cell Formatting (4 tools)
- Format range
- Merge cells
- Unmerge cells
- Get merged cells

### Cell Operations (2 tools)
- Apply formula
- Validate formula

### Tables and Ranges (7 tools)
- Create table
- Validate range
- Insert/delete rows and columns

### Advanced (3 tools)
- Create chart
- Create pivot table
- Get validation info

## Best Practices

### Data Operations
- Use batch writes instead of row-by-row
- Preview data before processing
- Read specific ranges, not entire files
- Apply formulas efficiently

### Formatting
- Format after data is written
- Use consistent colors and styles
- Apply number formats to columns
- Test formatting on samples first

### Performance
- Combine multiple operations
- Use specific ranges
- Batch similar operations
- Minimize file I/O

## Support

### For Questions
1. Check SKILL.md for overview
2. Review IMPLEMENTATION_GUIDE.md
3. Find matching pattern in common-patterns.md
4. Reference detailed guides

### For Issues
See Troubleshooting section in IMPLEMENTATION_GUIDE.md

## Integration

### Requirements
- Opencode with @zenobius/opencode-skillful plugin
- Excel MCP server configured (already in place)
- Skill discovery enabled

### How It Works
1. Agents discover skill with skill_find
2. Agents load skill with skill_use
3. Excel MCP available through skill guidance
4. Agents execute operations with confidence

## Version

- **Version**: 1.0
- **Created**: 2025-01-28
- **Status**: Production Ready
- **Lines**: 3,389
- **Files**: 7

## Next Steps

1. Load the skill: `skill_use "excel_operations"`
2. Ask AI for Excel help
3. Reference guides as needed
4. Explore different patterns

---

**Ready to use!** 🚀

Start with: `skill_find "excel"`
