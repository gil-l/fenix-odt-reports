package org.fenixedu.reports.domain;

import java.util.Iterator;
import java.util.Locale;

import org.fenixedu.bennu.io.domain.GenericFile;
import org.fenixedu.commons.i18n.LocalizedString;
import org.fenixedu.oddjet.Template;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

public class ReportTemplate extends ReportTemplate_Base {

    public ReportTemplate(String key, LocalizedString name, LocalizedString description, Locale locale, GenericFile file) {
        setReportKey(key);
        setName(name);
        setDescription(description);
        addLocalizedFileHistory(new LocalizedFileHistory(locale, file));
        setSystem(ReportTemplatesSystem.getInstance());
    }

    public Template getTemplate(Locale l) {
        return new Template(getTemplateFile(l).getContent(), l);
    }

    public GenericFile getTemplateFile(Locale l) {
        LocalizedFileHistory fileHistory =
                getLocalizedFileHistorySet().stream().filter(fh -> fh.getLocale().equals(l)).findFirst().orElse(null);
        return fileHistory.getLatestFile();
    }

    public void addTemplateFile(Locale l, GenericFile f) {
        LocalizedFileHistory fileHistory =
                getLocalizedFileHistorySet().stream().filter(fh -> fh.getLocale().equals(l)).findFirst().orElse(null);
        fileHistory.addTemplateFile(f);
    }

    @Atomic(mode = TxMode.WRITE)
    public void delete() {
        Iterator<LocalizedFileHistory> iterator = getLocalizedFileHistorySet().iterator();
        while (iterator.hasNext()) {
            LocalizedFileHistory fh = iterator.next();
            removeLocalizedFileHistory(fh);
            fh.delete();
        };
        setSystem(null);
        deleteDomainObject();
    };

}
