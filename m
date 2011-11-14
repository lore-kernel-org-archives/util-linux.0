Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:65201 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab1KNBsn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:43 -0500
Message-ID: <4EC07379.8090102@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:41 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 11/15] prlimit: avoid segfault due to array-out-of-bounds
 error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 11/15] prlimit: avoid segfault due to array-out-of-bounds error

prlimit used 1 element of the lims array per limit given on the command
line argument, not being aware that a user would pass the value of the
soft and the hard limit in different options - leading to a segfault
when the user passes more than MAX_RESOURCES limit options.
As a side effect, a limit was retrieved and printed several times if
the corresponding option appeared multiple times.

Example:
$ prlimit -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l -l
RESOURCE DESCRIPTION                         SOFT   HARD UNITS
MEMLOCK  max locked-in-memory address space 65536 262144 bytes
MEMLOCK  max locked-in-memory address space 65536 262144 bytes
...
Segmentation fault

Use the lims array in a more direct way, i.e. the index is limit id.
Initialize lims array and adapt option parsing in main() accordingly.
do_prlimits() and show_limits(): loop over all MAX_RESOURCES in the
lims array.
Fix limit parsing in parse_prlim() and add_prlim() to be aware of
soft and hard limits in separate program arguments.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   32 ++++++++++++++++++++++----------
  1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index fc11a94..1d6dd92 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -265,7 +265,7 @@ static int column_name_to_id(const char *name, 
size_t namesz)
  	return -1;
  }

-static int show_limits(struct prlimit lims[], size_t n, int tt_flags)
+static int show_limits(struct prlimit lims[], int tt_flags)
  {
  	int i;
  	struct tt *tt;
@@ -285,7 +285,7 @@ static int show_limits(struct prlimit lims[], size_t 
n, int tt_flags)
  		}
  	}

-	for (i = 0; (size_t) i < n; i++)
+	for (i = 0; (size_t) i < MAX_RESOURCES; i++)
  		if (lims[i].show)
  			add_tt_line(tt, &lims[i]);

@@ -327,11 +327,11 @@ static void get_unknown_hardsoft(struct prlimit *lim)
  	}
  }

-static void do_prlimit(struct prlimit lims[], size_t n, int tt_flags)
+static void do_prlimit(struct prlimit lims[], int tt_flags)
  {
  	size_t i;

-	for (i = 0; i < n; i++) {
+	for (i = 0; i < MAX_RESOURCES; i++) {
  		struct rlimit *new = NULL;

  		if (lims[i].modify) {
@@ -458,8 +458,10 @@ static int parse_prlim(struct rlimit *lim, char 
*ops, size_t id)
  		errx(EXIT_FAILURE, _("failed to parse %s limit"),
  		     prlimit_desc[id].name);

-	lim->rlim_cur = soft;
-	lim->rlim_max = hard;
+	if (modify & PRLIMIT_SOFT)
+		lim->rlim_cur = soft;
+	if (modify & PRLIMIT_HARD)
+		lim->rlim_max = hard;

  	return modify;
  }
@@ -474,7 +476,7 @@ static int add_prlim(char *ops, struct prlimit *lim, 
size_t id)
  	if (ops) { /* planning on modifying a limit? */
  		int modify = parse_prlim(&lim->rlim, ops, id);
  		if (modify)
-			lim->modify = 1;
+			lim->modify |= modify;
  		else
  			lim->show = 1;
  	} else {
@@ -553,6 +555,15 @@ int main(int argc, char **argv)
  	 */
  	assert(MAX_RESOURCES == STACK + 1);

+	/*
+	 * initialize limits array */
+	for (n = 0; n < MAX_RESOURCES; n++) {
+		lims[n].desc = &prlimit_desc[n];
+		lims[n].rlim.rlim_cur = lims[n].rlim.rlim_max = 0;
+		lims[n].modify = lims[n].show = 0;
+	}
+	n = 0;
+
  	while((opt = getopt_long(argc, argv,
  				 "c::d::e::f::i::l::m::n::q::r::s::t::u::v::x::y::p:o:vVh",
  				 longopts, NULL)) != -1) {
@@ -573,7 +584,8 @@ int main(int argc, char **argv)
  		case 'v':
  		case 'x':
  		case 'y':
-				add_prlim(optarg, &lims[n++], opt_id[opt]);
+				add_prlim(optarg, &lims[opt_id[opt]], opt_id[opt]);
+				n++;
  				break;

  		case 'p':
@@ -629,8 +641,8 @@ int main(int argc, char **argv)
  			add_prlim(NULL, &lims[n], n);
  	}

-	do_prlimit(lims, n, tt_flags);
-	show_limits(lims, n, tt_flags);
+	do_prlimit(lims, tt_flags);
+	show_limits(lims, tt_flags);

  	return EXIT_SUCCESS;
  }
