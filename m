Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34916 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcCNVYl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2016 17:24:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id n205so128859wmf.2
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2016 14:24:40 -0700 (PDT)
Date: Mon, 14 Mar 2016 21:24:32 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] getopt: fix memory leaks and integer overflows
 [ASAN & valgrind]
In-Reply-To: <m37fh6inlh.fsf@gmail.com>
Message-ID: <alpine.LNX.2.20.1603142118420.10152@imuri>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi> <1457865109-2881-3-git-send-email-kerolasa@iki.fi> <m37fh6inlh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 13 Mar 2016, Yuriy M. Kaminskiy wrote:

> On 03/13/16 13:31 , Sami Kerola wrote:
> > The getopt(1) is short living command, and one could argue ensuring all
> > allocations are freed at end of execution is waste of time.  There is a
> > point in that, but making test-suite runs to be less noisy with ASAN is also
> > nice as it encourages reading the errors when/if they happen.
> >
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  misc-utils/getopt.c | 36 ++++++++++++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
> > index c4144f6..be2ed38 100644
> > --- a/misc-utils/getopt.c
> > +++ b/misc-utils/getopt.c
> > @@ -79,13 +79,23 @@
> >  /* The shells recognized. */
> >  typedef enum { BASH, TCSH } shell_t;
> >  
> > +/* This is a copy of getopt_long(3) structure, in which *name does not have
> > + * const, so that is can be free'd at end of execution.  */
> > +struct getoption {
> > +	char *name;
> > +	int has_arg;
> > +	int *flag;
> > +	int val;
> > +};
> 
> What will happen if some implementation will add new fields in `struct
> option`? (Sure, unlikely, but).
> IMO, `free((char *)option->name)` is *much* safer.

Hi Yuriy and Karel,

Okay, sounds fair adding a 'copy struct' wasn't the brightest idea ever.  
See below a const cast to read-write char pointer. This seems to make 
compiler happy.


--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 14 Mar 2016 21:06:30 +0000
Subject: getopt: fix memory leaks and integer overflows [ASAN & valgrind]

The getopt(1) is short living command, and one could argue ensuring all
allocations are freed at end of execution is waste of time.  There is a
point in that, but making test-suite runs to be less noisy with ASAN is
also nice as it encourages reading the errors when/if they happen.

Reviewed-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
Reviewed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index c4144f6..7f4547c 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -86,6 +86,7 @@ struct getopt_control {
 	int long_options_length;	/* length of options array */
 	int long_options_nr;		/* number of used elements in array */
 	unsigned int
+		free_name:1,		/* free up argv[0] after printout */
 		compatible:1,		/* compatibility mode for 'difficult' programs */
 		quiet_errors:1,		/* print errors */
 		quiet_output:1,		/* print output */
@@ -181,7 +182,7 @@ static void print_normalized(const struct getopt_control *ctl, const char *arg)
  * optstr must contain the short options, and longopts the long options.
  * Other settings are found in global variables.
  */
-static int generate_output(const struct getopt_control *ctl, char *argv[], int argc)
+static int generate_output(struct getopt_control *ctl, char *argv[], int argc)
 {
 	int exit_code = EXIT_SUCCESS;	/* Assume everything will be OK */
 	int opt;
@@ -195,8 +196,10 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
 	optind = 0;
 
 	while ((opt =
-		(getopt_long_fp(argc, argv, ctl->optstr, ctl->long_options, &longindex)))
-	       != EOF)
+		(getopt_long_fp
+		 (argc, argv, ctl->optstr,
+		  (const struct option *)ctl->long_options, &longindex)))
+	       != EOF) {
 		if (opt == '?' || opt == ':')
 			exit_code = GETOPT_EXIT_CODE;
 		else if (!ctl->quiet_output) {
@@ -216,13 +219,19 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
 					print_normalized(ctl, optarg ? optarg : "");
 			}
 		}
-
+	}
 	if (!ctl->quiet_output) {
 		printf(" --");
 		while (optind < argc)
 			print_normalized(ctl, argv[optind++]);
 		printf("\n");
 	}
+	for (longindex = 0; longindex < ctl->long_options_nr; longindex++)
+		free((char *)ctl->long_options[longindex].name);
+	free(ctl->long_options);
+	free(ctl->optstr);
+	if (ctl->free_name)
+		free(argv[0]);
 	return exit_code;
 }
 
@@ -373,9 +382,6 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	add_longopt(&ctl, NULL, 0);	/* init */
-	getopt_long_fp = getopt_long;
-
 	if (getenv("GETOPT_COMPATIBLE"))
 		ctl.compatible = 1;
 
@@ -391,6 +397,9 @@ int main(int argc, char *argv[])
 			parse_error(_("missing optstring argument"));
 	}
 
+	add_longopt(&ctl, NULL, 0);	/* init */
+	getopt_long_fp = getopt_long;
+
 	if (argv[1][0] != '-' || ctl.compatible) {
 		ctl.quote = 0;
 		ctl.optstr = xmalloc(strlen(argv[1]) + 1);
@@ -417,6 +426,7 @@ int main(int argc, char *argv[])
 		case 'n':
 			free(name);
 			name = xstrdup(optarg);
+			ctl.free_name = 1;
 			break;
 		case 'q':
 			ctl.quiet_errors = 1;
@@ -428,6 +438,7 @@ int main(int argc, char *argv[])
 			ctl.shell = shell_type(optarg);
 			break;
 		case 'T':
+			free(ctl.long_options);
 			return TEST_EXIT_CODE;
 		case 'u':
 			ctl.quote = 0;
-- 
2.7.3

