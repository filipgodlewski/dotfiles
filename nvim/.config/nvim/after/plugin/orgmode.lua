require('orgmode').setup({
  org_agenda_files = {'~/Documents/org/*'};
  org_default_notes_file = '~/Documents/org/dump.org';
  org_hide_leading_stars = true;
  org_agenda_templates = {
     j = {
        description = 'Journal';
        template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?';
        target = '~/Documents/org/journal.org';
     },
     d = {
        description = 'Brain Dump';
        template = '\n%?';
        target = '~/Documents/org/dump.org';
     }
  };
})
