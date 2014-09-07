Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53840 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaIGMnt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:49 -0400
Received: by mail-wg0-f47.google.com with SMTP id z12so13493378wgg.6
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/17] setarch: reindent code
Date: Sun,  7 Sep 2014 13:43:03 +0100
Message-Id: <1410093785-17537-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.c | 507 +++++++++++++++++++++++++---------------------------
 1 file changed, 248 insertions(+), 259 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 4cce877..468e492 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -41,7 +41,7 @@
 
 /* Options without equivalent short options */
 enum {
-	OPT_4GB		= CHAR_MAX + 1,
+	OPT_4GB = CHAR_MAX + 1,
 	OPT_UNAME26
 };
 
@@ -52,7 +52,6 @@ enum {
 			printf(_("Switching on %s.\n"), #_flag); \
 	} while(0)
 
-
 #ifndef UNAME26
 # define UNAME26                 0x0020000
 #endif
@@ -87,301 +86,291 @@ enum {
 # define ADDR_LIMIT_3GB          0x8000000
 #endif
 
-static void __attribute__((__noreturn__))
-show_help(void)
+static void __attribute__((__noreturn__)) show_help(void)
 {
-  fputs(USAGE_HEADER, stdout);
-  printf(_(" %s%s [options] [program [program arguments]]\n"),
-	 program_invocation_short_name,
-	 !strcmp(program_invocation_short_name, "setarch") ? " <arch>" : "");
-
-  fputs(USAGE_OPTIONS, stdout);
-  fputs(_(" -v, --verbose            says what options are being switched on\n"), stdout);
-  fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
-  fputs(_(" -F, --fdpic-funcptrs     makes function pointers point to descriptors\n"), stdout);
-  fputs(_(" -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"), stdout);
-  fputs(_(" -L, --addr-compat-layout changes the way virtual memory is allocated\n"), stdout);
-  fputs(_(" -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"), stdout);
-  fputs(_(" -B, --32bit              turns on ADDR_LIMIT_32BIT\n"), stdout);
-  fputs(_(" -I, --short-inode        turns on SHORT_INODE\n"), stdout);
-  fputs(_(" -S, --whole-seconds      turns on WHOLE_SECONDS\n"), stdout);
-  fputs(_(" -T, --sticky-timeouts    turns on STICKY_TIMEOUTS\n"), stdout);
-  fputs(_(" -3, --3gb                limits the used address space to a maximum of 3 GB\n"), stdout);
-  fputs(_("     --4gb                ignored (for backward compatibility only)\n"), stdout);
-  fputs(_("     --uname-2.6          turns on UNAME26\n"), stdout);
-  fputs(_("     --list               list settable architectures, and exit\n"), stdout);
-
-  fputs(USAGE_SEPARATOR, stdout);
-  fputs(USAGE_HELP, stdout);
-  fputs(USAGE_VERSION, stdout);
-  printf(USAGE_MAN_TAIL("setarch(8)"));
-
-  exit(EXIT_SUCCESS);
+	fputs(USAGE_HEADER, stdout);
+	printf(_(" %s%s [options] [program [program arguments]]\n"),
+	       program_invocation_short_name,
+	       !strcmp(program_invocation_short_name, "setarch") ? " <arch>" : "");
+	fputs(USAGE_OPTIONS, stdout);
+	fputs(_(" -v, --verbose            says what options are being switched on\n"), stdout);
+	fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
+	fputs(_(" -F, --fdpic-funcptrs     makes function pointers point to descriptors\n"), stdout);
+	fputs(_(" -Z, --mmap-page-zero     turns on MMAP_PAGE_ZERO\n"), stdout);
+	fputs(_(" -L, --addr-compat-layout changes the way virtual memory is allocated\n"), stdout);
+	fputs(_(" -X, --read-implies-exec  turns on READ_IMPLIES_EXEC\n"), stdout);
+	fputs(_(" -B, --32bit              turns on ADDR_LIMIT_32BIT\n"), stdout);
+	fputs(_(" -I, --short-inode        turns on SHORT_INODE\n"), stdout);
+	fputs(_(" -S, --whole-seconds      turns on WHOLE_SECONDS\n"), stdout);
+	fputs(_(" -T, --sticky-timeouts    turns on STICKY_TIMEOUTS\n"), stdout);
+	fputs(_(" -3, --3gb                limits the used address space to a maximum of 3 GB\n"), stdout);
+	fputs(_("     --4gb                ignored (for backward compatibility only)\n"), stdout);
+	fputs(_("     --uname-2.6          turns on UNAME26\n"), stdout);
+	fputs(_("     --list               list settable architectures, and exit\n"), stdout);
+	fputs(USAGE_SEPARATOR, stdout);
+	fputs(USAGE_HELP, stdout);
+	fputs(USAGE_VERSION, stdout);
+	printf(USAGE_MAN_TAIL("setarch(8)"));
+	exit(EXIT_SUCCESS);
 }
 
-static void __attribute__((__noreturn__))
-show_usage(const char *s)
+static void __attribute__((__noreturn__)) show_usage(const char *s)
 {
-  if (s)
-    errx(EXIT_FAILURE, _("%s\nTry `%s --help' for more information."), s, program_invocation_short_name);
-  else
-    errx(EXIT_FAILURE, _("Try `%s --help' for more information."), program_invocation_short_name);
+	if (s)
+		errx(EXIT_FAILURE,
+		     _("%s\nTry `%s --help' for more information."), s,
+		     program_invocation_short_name);
+	else
+		errx(EXIT_FAILURE, _("Try `%s --help' for more information."),
+		     program_invocation_short_name);
 }
 
 static void __attribute__((__noreturn__))
-show_version(void)
+    show_version(void)
 {
-  printf(UTIL_LINUX_VERSION);
-  exit(EXIT_SUCCESS);
+	printf(UTIL_LINUX_VERSION);
+	exit(EXIT_SUCCESS);
 }
 
-static int
-set_arch(const char *pers, unsigned long options, int list)
+static int set_arch(const char *pers, unsigned long options, int list)
 {
-  struct utsname un;
-  int i;
-  unsigned long pers_value;
-
-  struct {
-    int perval;
-    const char *target_arch, *result_arch;
-  } transitions[] = {
-    {UNAME26, "uname26", NULL},
-    {PER_LINUX32, "linux32", NULL},
-    {PER_LINUX, "linux64", NULL},
+	struct utsname un;
+	int i;
+	unsigned long pers_value;
+
+	struct {
+		int perval;
+		const char *target_arch, *result_arch;
+	} transitions[] = {
+		{UNAME26,	"uname26",	NULL},
+		{PER_LINUX32,	"linux32",	NULL},
+		{PER_LINUX,	"linux64",	NULL},
 #if defined(__powerpc__) || defined(__powerpc64__)
-#ifdef __BIG_ENDIAN__
-    {PER_LINUX32, "ppc32", "ppc"},
-    {PER_LINUX32, "ppc", "ppc"},
-    {PER_LINUX, "ppc64", "ppc64"},
-    {PER_LINUX, "ppc64pseries", "ppc64"},
-    {PER_LINUX, "ppc64iseries", "ppc64"},
-#else
-    {PER_LINUX32, "ppc32le", "ppcle"},
-    {PER_LINUX32, "ppcle", "ppcle"},
-    {PER_LINUX, "ppc64le", "ppc64le"},
-#endif
+# ifdef __BIG_ENDIAN__
+		{PER_LINUX32,	"ppc32",	"ppc"},
+		{PER_LINUX32,	"ppc",		"ppc"},
+		{PER_LINUX,	"ppc64",	"ppc64"},
+		{PER_LINUX,	"ppc64pseries",	"ppc64"},
+		{PER_LINUX,	"ppc64iseries",	"ppc64"},
+# else
+		PER_LINUX32,	"ppc32le",	"ppcle"},
+		PER_LINUX32,	"ppcle",	"ppcle"},
+		PER_LINUX,	"ppc64le",	"ppc64le"},
+# endif
 #endif
 #if defined(__x86_64__) || defined(__i386__) || defined(__ia64__)
-    {PER_LINUX32, "i386", "i386"},
-    {PER_LINUX32, "i486", "i386"},
-    {PER_LINUX32, "i586", "i386"},
-    {PER_LINUX32, "i686", "i386"},
-    {PER_LINUX32, "athlon", "i386"},
+		{PER_LINUX32,	"i386",		"i386"},
+		{PER_LINUX32,	"i486",		"i386"},
+		{PER_LINUX32,	"i586",		"i386"},
+		{PER_LINUX32,	"i686",		"i386"},
+		{PER_LINUX32,	"athlon",	"i386"},
 #endif
 #if defined(__x86_64__) || defined(__i386__)
-    {PER_LINUX, "x86_64", "x86_64"},
+		{PER_LINUX,	"x86_64",	"x86_64"},
 #endif
 #if defined(__ia64__) || defined(__i386__)
-    {PER_LINUX, "ia64", "ia64"},
+		{PER_LINUX,	"ia64",		"ia64"},
 #endif
 #if defined(__hppa__)
-    {PER_LINUX32, "parisc32", "parisc"},
-    {PER_LINUX32, "parisc", "parisc"},
-    {PER_LINUX, "parisc64", "parisc64"},
+		{PER_LINUX32,	"parisc32",	"parisc"},
+		{PER_LINUX32,	"parisc",	"parisc"},
+		{PER_LINUX,	"parisc64",	"parisc64"},
 #endif
 #if defined(__s390x__) || defined(__s390__)
-    {PER_LINUX32, "s390", "s390"},
-    {PER_LINUX, "s390x", "s390x"},
+		{PER_LINUX32,	"s390",		"s390"},
+		{PER_LINUX,	"s390x",	"s390x"},
 #endif
 #if defined(__sparc64__) || defined(__sparc__)
-    {PER_LINUX32, "sparc", "sparc"},
-    {PER_LINUX32, "sparc32bash", "sparc"},
-    {PER_LINUX32, "sparc32", "sparc"},
-    {PER_LINUX, "sparc64", "sparc64"},
+		{PER_LINUX32,	"sparc",	"sparc"},
+		{PER_LINUX32,	"sparc32bash",	"sparc"},
+		{PER_LINUX32,	"sparc32",	"sparc"},
+		{PER_LINUX,	"sparc64",	"sparc64"},
 #endif
 #if defined(__mips64__) || defined(__mips__)
-    {PER_LINUX32, "mips32", "mips"},
-    {PER_LINUX32, "mips", "mips"},
-    {PER_LINUX, "mips64", "mips64"},
+		{PER_LINUX32,	"mips32",	"mips"},
+		{PER_LINUX32,	"mips",		"mips"},
+		{PER_LINUX,	"mips64",	"mips64"},
 #endif
 #if defined(__alpha__)
-    {PER_LINUX, "alpha", "alpha"},
-    {PER_LINUX, "alphaev5", "alpha"},
-    {PER_LINUX, "alphaev56", "alpha"},
-    {PER_LINUX, "alphaev6", "alpha"},
-    {PER_LINUX, "alphaev67", "alpha"},
+		{PER_LINUX,	"alpha",	"alpha"},
+		{PER_LINUX,	"alphaev5",	"alpha"},
+		{PER_LINUX,	"alphaev56",	"alpha"},
+		{PER_LINUX,	"alphaev6",	"alpha"},
+		{PER_LINUX,	"alphaev67",	"alpha"},
 #endif
-    {-1, NULL, NULL}, /* place holder, eventually filled up at runtime */
-    {-1, NULL, NULL}
-  };
-
-  /* Add the trivial transition {PER_LINUX, machine, machine} if no such
-     target_arch is hardcoded yet. */
-  uname(&un);
-  for (i = 0; transitions[i].perval >= 0; i++)
-	if(!strcmp(un.machine, transitions[i].target_arch))
-		break;
-  if (transitions[i].perval < 0) {
-	unsigned long wrdsz = CHAR_BIT * sizeof(void*);
-	if (wrdsz == 32 || wrdsz == 64) {
-		transitions[i].perval = wrdsz == 32 ? PER_LINUX32 : PER_LINUX;
-		transitions[i].target_arch = un.machine;
-		transitions[i].result_arch = un.machine;
+		/* place holder, will be filled up at runtime */
+		{-1,		NULL,		NULL},
+		{-1,		NULL,		NULL}
+	};
+
+	/* Add the trivial transition {PER_LINUX, machine, machine} if no
+	 * such target_arch is hardcoded yet.  */
+	uname(&un);
+	for (i = 0; transitions[i].perval >= 0; i++)
+		if (!strcmp(un.machine, transitions[i].target_arch))
+			break;
+	if (transitions[i].perval < 0) {
+		unsigned long wrdsz = CHAR_BIT * sizeof(void *);
+		if (wrdsz == 32 || wrdsz == 64) {
+			/* fill up the place holder */
+			transitions[i].perval = wrdsz == 32 ? PER_LINUX32 : PER_LINUX;
+			transitions[i].target_arch = un.machine;
+			transitions[i].result_arch = un.machine;
+		}
 	}
-  }
-
-  if (list) {
-    for(i = 0; transitions[i].target_arch != NULL; i++)
-      printf("%s\n", transitions[i].target_arch);
-    return 0;
-  }
-
-  for(i = 0; transitions[i].perval >= 0; i++)
-      if(!strcmp(pers, transitions[i].target_arch))
-	break;
-
-  if(transitions[i].perval < 0)
-    errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
-
-  pers_value = transitions[i].perval | options;
-  if (set_pers(pers_value) == -EINVAL)
-    return 1;
-
-  uname(&un);
-  if(transitions[i].result_arch &&
-	strcmp(un.machine, transitions[i].result_arch))
-  {
-    if(strcmp(transitions[i].result_arch, "i386")
-       || (strcmp(un.machine, "i486")
-	   && strcmp(un.machine, "i586")
-	   && strcmp(un.machine, "i686")
-	   && strcmp(un.machine, "athlon")))
-      errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
-  }
-
-  return 0;
+	if (list) {
+		for (i = 0; transitions[i].target_arch != NULL; i++)
+			printf("%s\n", transitions[i].target_arch);
+		return 0;
+	}
+	for (i = 0; transitions[i].perval >= 0; i++)
+		if (!strcmp(pers, transitions[i].target_arch))
+			break;
+	if (transitions[i].perval < 0)
+		errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
+	pers_value = transitions[i].perval | options;
+	if (set_pers(pers_value) == -EINVAL)
+		return 1;
+	uname(&un);
+	if (transitions[i].result_arch && strcmp(un.machine, transitions[i].result_arch)) {
+		if (strcmp(transitions[i].result_arch, "i386")
+		    || (strcmp(un.machine, "i486")
+			&& strcmp(un.machine, "i586")
+			&& strcmp(un.machine, "i686")
+			&& strcmp(un.machine, "athlon")))
+			errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
+	}
+	return 0;
 }
 
 int main(int argc, char *argv[])
 {
-  const char *p;
-  unsigned long options = 0;
-  int verbose = 0;
-  int c;
-
-  /* Options --3gb and --4gb are for compatibitity with an old Debian setarch
-     implementation. */
-  static const struct option longopts[] =
-  {
-      { "help",               0, 0, 'h' },
-      { "version",            0, 0, 'V' },
-      { "verbose",            0, 0, 'v' },
-      { "addr-no-randomize",  0, 0, 'R' },
-      { "fdpic-funcptrs",     0, 0, 'F' },
-      { "mmap-page-zero",     0, 0, 'Z' },
-      { "addr-compat-layout", 0, 0, 'L' },
-      { "read-implies-exec",  0, 0, 'X' },
-      { "32bit",              0, 0, 'B' },
-      { "short-inode",        0, 0, 'I' },
-      { "whole-seconds",      0, 0, 'S' },
-      { "sticky-timeouts",    0, 0, 'T' },
-      { "3gb",                0, 0, '3' },
-      { "4gb",                0, 0, OPT_4GB },
-      { "uname-2.6",          0, 0, OPT_UNAME26 },
-      { NULL,                 0, 0, 0 }
-  };
-
-  setlocale(LC_ALL, "");
-  bindtextdomain(PACKAGE, LOCALEDIR);
-  textdomain(PACKAGE);
-  atexit(close_stdout);
-
-  if (argc < 1)
-    show_usage(_("Not enough arguments"));
-
-  p = program_invocation_short_name;
-  if (!strcmp(p, "setarch")) {
-    argc--;
-    if (argc < 1)
-      show_usage(_("Not enough arguments"));
-    p = argv[1];
-    argv[1] = argv[0];		/* for getopt_long() to get the program name */
-    argv++;
-    if (!strcmp(p, "-h") || !strcmp(p, "--help"))
-      show_help();
-    else if (!strcmp(p, "-V") || !strcmp(p, "--version"))
-      show_version();
-    else if (!strcmp(p, "--list")) {
-      set_arch(argv[0], 0L, 1);
-      return EXIT_SUCCESS;
-    }
-  }
-  #if defined(__sparc64__) || defined(__sparc__)
-   if (!strcmp(p, "sparc32bash")) {
-       if (set_arch(p, 0L, 0))
-           err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
-       execl("/bin/bash", NULL);
-       err(EXIT_FAILURE, _("failed to execute %s"), "/bin/bash");
-   }
-  #endif
+	const char *p;
+	unsigned long options = 0;
+	int verbose = 0;
+	int c;
+
+	/* Options --3gb and --4gb are for compatibitity with an old
+	 * Debian setarch implementation.  */
+	static const struct option longopts[] = {
+		{"help",		no_argument,	NULL,	'h'},
+		{"version",		no_argument,	NULL,	'V'},
+		{"verbose",		no_argument,	NULL,	'v'},
+		{"addr-no-randomize",	no_argument,	NULL,	'R'},
+		{"fdpic-funcptrs",	no_argument,	NULL,	'F'},
+		{"mmap-page-zero",	no_argument,	NULL,	'Z'},
+		{"addr-compat-layout",	no_argument,	NULL,	'L'},
+		{"read-implies-exec",	no_argument,	NULL,	'X'},
+		{"32bit",		no_argument,	NULL,	'B'},
+		{"short-inode",		no_argument,	NULL,	'I'},
+		{"whole-seconds",	no_argument,	NULL,	'S'},
+		{"sticky-timeouts",	no_argument,	NULL,	'T'},
+		{"3gb",			no_argument,	NULL,	'3'},
+		{"4gb",			no_argument,	NULL,	OPT_4GB},
+		{"uname-2.6",		no_argument,	NULL,	OPT_UNAME26},
+		{NULL,			0,		NULL,	0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	if (argc < 1)
+		show_usage(_("Not enough arguments"));
+
+	p = program_invocation_short_name;
+	if (!strcmp(p, "setarch")) {
+		argc--;
+		if (argc < 1)
+			show_usage(_("Not enough arguments"));
+		p = argv[1];
+		argv[1] = argv[0];	/* for getopt_long() to get the program name */
+		argv++;
+		if (!strcmp(p, "-h") || !strcmp(p, "--help"))
+			show_help();
+		else if (!strcmp(p, "-V") || !strcmp(p, "--version"))
+			show_version();
+		else if (!strcmp(p, "--list")) {
+			set_arch(argv[0], 0L, 1);
+			return EXIT_SUCCESS;
+		}
+	}
+#if defined(__sparc64__) || defined(__sparc__)
+	if (!strcmp(p, "sparc32bash")) {
+		if (set_arch(p, 0L, 0))
+			err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
+		execl("/bin/bash", NULL);
+		err(EXIT_FAILURE, _("failed to execute %s"), "/bin/bash");
+	}
+#endif
 
-  while ((c = getopt_long(argc, argv, "+hVv3BFILRSTXZ", longopts, NULL)) != -1) {
-    switch (c) {
-    case 'h':
-      show_help();
-      break;
-    case 'V':
-      show_version();
-      break;
-    case 'v':
-      verbose = 1;
-      break;
-    case 'R':
-	turn_on(ADDR_NO_RANDOMIZE, options);
-	break;
-    case 'F':
-	turn_on(FDPIC_FUNCPTRS, options);
-	break;
-    case 'Z':
-	turn_on(MMAP_PAGE_ZERO, options);
-	break;
-    case 'L':
-	turn_on(ADDR_COMPAT_LAYOUT, options);
-	break;
-    case 'X':
-	turn_on(READ_IMPLIES_EXEC, options);
-	break;
-    case 'B':
-	turn_on(ADDR_LIMIT_32BIT, options);
-	break;
-    case 'I':
-	turn_on(SHORT_INODE, options);
-	break;
-    case 'S':
-	turn_on(WHOLE_SECONDS, options);
-	break;
-    case 'T':
-	turn_on(STICKY_TIMEOUTS, options);
-	break;
-    case '3':
-	turn_on(ADDR_LIMIT_3GB, options);
-	break;
-    case OPT_4GB:          /* just ignore this one */
-      break;
-    case OPT_UNAME26:
-	turn_on(UNAME26, options);
-	break;
-    default:
-        show_usage(NULL);
-    }
-  }
+	while ((c = getopt_long(argc, argv, "+hVv3BFILRSTXZ", longopts, NULL)) != -1) {
+		switch (c) {
+		case 'h':
+			show_help();
+			break;
+		case 'V':
+			show_version();
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'R':
+			turn_on(ADDR_NO_RANDOMIZE, options);
+			break;
+		case 'F':
+			turn_on(FDPIC_FUNCPTRS, options);
+			break;
+		case 'Z':
+			turn_on(MMAP_PAGE_ZERO, options);
+			break;
+		case 'L':
+			turn_on(ADDR_COMPAT_LAYOUT, options);
+			break;
+		case 'X':
+			turn_on(READ_IMPLIES_EXEC, options);
+			break;
+		case 'B':
+			turn_on(ADDR_LIMIT_32BIT, options);
+			break;
+		case 'I':
+			turn_on(SHORT_INODE, options);
+			break;
+		case 'S':
+			turn_on(WHOLE_SECONDS, options);
+			break;
+		case 'T':
+			turn_on(STICKY_TIMEOUTS, options);
+			break;
+		case '3':
+			turn_on(ADDR_LIMIT_3GB, options);
+			break;
+		case OPT_4GB:	/* just ignore this one */
+			break;
+		case OPT_UNAME26:
+			turn_on(UNAME26, options);
+			break;
+		default:
+			show_usage(NULL);
+		}
+	}
 
-  argc -= optind;
-  argv += optind;
+	argc -= optind;
+	argv += optind;
 
-  if (set_arch(p, options, 0))
-    err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
+	if (set_arch(p, options, 0))
+		err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
 
-  /* flush all output streams before exec */
-  fflush(NULL);
+	/* flush all output streams before exec */
+	fflush(NULL);
 
-  if (!argc) {
-    execl("/bin/sh", "-sh", NULL);
-    err(EXIT_FAILURE, _("failed to execute %s"), "/bin/sh");
-  }
+	if (!argc) {
+		execl("/bin/sh", "-sh", NULL);
+		err(EXIT_FAILURE, _("failed to execute %s"), "/bin/sh");
+	}
 
-  execvp(argv[0], argv);
-  err(EXIT_FAILURE, "%s", argv[0]);
-  return EXIT_FAILURE;
+	execvp(argv[0], argv);
+	err(EXIT_FAILURE, "%s", argv[0]);
+	return EXIT_FAILURE;
 }
-- 
2.1.0

