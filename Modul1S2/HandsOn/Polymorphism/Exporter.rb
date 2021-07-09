class GenericExporter
    def export
        raise NotImplementedError, "you must implement the method"
    end
end

class PdfExporter < GenericExporter
    def export
        puts 'Export to .pdf'
    end
end

class XlsExporter < GenericExporter
    def export
        puts 'Export to .xls'
    end
end