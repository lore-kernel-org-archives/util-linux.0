Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53201 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754937AbdFXOFJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 10:05:09 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, luto@kernel.org, kzak@redhat.com
Subject: [PATCH 5/5] setpriv: support modifying the set of ambient capabilities
Date: Sat, 24 Jun 2017 16:04:34 +0200
Message-Id: <cd10a8262a2accb0f3fdaf92aad8cdc488c5d3c7.1498312679.git.ps@pks.im>
In-Reply-To: <cover.1498312509.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im>
In-Reply-To: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Right now, we do not support modifying the set of ambient capabilities,
which has been introduced quite recently with Linux 4.3. As libcap-ng
does not yet provide any ability to modify this set, we do have to roll
our own support via `prctl`, which is now easy to do due to the
indirections introduced in the preceding commits. We add a new command
line argument "--ambient-caps", which uses the same syntax as both
"--inh-caps" and "--bounding-set" to specify either adding or dropping
capabilities.

This commit also adjusts documentation to mention the newly introduced
ability to modify the ambient capability set.

Based on a patch by Andy Lutomirski.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.1 |  8 +++++---
 sys-utils/setpriv.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index be97c0799..b0cc33a2b 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -27,8 +27,8 @@ mostly useless, information.  Incompatible with all other options.
 .B \-\-groups \fIgroup\fR...
 Set supplementary groups.  The argument is a comma-separated list.
 .TP
-.BR \-\-inh\-caps " (" + | \- ) \fIcap "...  or  " \-\-bounding\-set " (" + | \- ) \fIcap ...
-Set the inheritable capabilities or the capability bounding set.  See
+.BR \-\-inh\-caps " (" + | \- ) \fIcap "...  or  " \-\-ambient-caps " (" + | \- ) \fIcap "...  or  " \-\-bounding\-set " (" + | \- ) \fIcap ...
+Set the inheritable capabilities, ambient capabilities or the capability bounding set.  See
 .BR capabilities (7).
 The argument is a comma-separated list of
 .BI + cap
@@ -40,7 +40,9 @@ and
 .B \-all
 can be used to add or remove all caps.  The set of capabilities starts out as
 the current inheritable set for
-.B \-\-inh\-caps
+.BR \-\-inh\-caps ,
+the current ambient set for
+.B \-\-ambient\-caps
 and the current bounding set for
 .BR \-\-bounding\-set .
 If you drop something from the bounding set without also dropping it from the
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index c0276ed27..8e38211e7 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -49,6 +49,8 @@
 #ifndef PR_CAP_AMBIENT
 # define PR_CAP_AMBIENT		47
 #  define PR_CAP_AMBIENT_IS_SET	1
+#  define PR_CAP_AMBIENT_RAISE	2
+#  define PR_CAP_AMBIENT_LOWER	3
 #endif
 
 #define SETPRIV_EXIT_PRIVERR 127	/* how we exit when we fail to set privs */
@@ -95,6 +97,7 @@ struct privctx {
 
 	/* caps */
 	const char *caps_to_inherit;
+	const char *ambient_caps;
 	const char *bounding_set;
 
 	/* securebits */
@@ -479,6 +482,19 @@ static int cap_update(capng_act_t action,
 		case CAP_TYPE_INHERITABLE:
 		case CAP_TYPE_PERMITTED:
 			return capng_update(action, (capng_type_t) type, cap);
+		case CAP_TYPE_AMBIENT:
+		{
+			int ret;
+
+			if (action == CAPNG_ADD)
+				ret = prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE,
+						(unsigned long) cap, 0UL, 0UL);
+			else
+				ret = prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_LOWER,
+						(unsigned long) cap, 0UL, 0UL);
+
+			return ret;
+		}
 		default:
 			errx(EXIT_FAILURE, _("unsupported capability type"));
 			return -1;
@@ -687,6 +703,7 @@ int main(int argc, char **argv)
 		INIT_GROUPS,
 		GROUPS,
 		INHCAPS,
+		AMBCAPS,
 		LISTCAPS,
 		CAPBSET,
 		SECUREBITS,
@@ -699,6 +716,7 @@ int main(int argc, char **argv)
 		{ "nnp",              no_argument,       NULL, NNP              },
 		{ "no-new-privs",     no_argument,       NULL, NNP              },
 		{ "inh-caps",         required_argument, NULL, INHCAPS          },
+		{ "ambient-caps",     required_argument, NULL, AMBCAPS          },
 		{ "list-caps",        no_argument,       NULL, LISTCAPS         },
 		{ "ruid",             required_argument, NULL, RUID             },
 		{ "euid",             required_argument, NULL, EUID             },
@@ -831,6 +849,12 @@ int main(int argc, char **argv)
 				     _("duplicate --inh-caps option"));
 			opts.caps_to_inherit = optarg;
 			break;
+		case AMBCAPS:
+			if (opts.ambient_caps)
+				errx(EXIT_FAILURE,
+				     _("duplicate --ambient-caps option"));
+			opts.ambient_caps = optarg;
+			break;
 		case CAPBSET:
 			if (opts.bounding_set)
 				errx(EXIT_FAILURE,
@@ -957,6 +981,10 @@ int main(int argc, char **argv)
 			err(SETPRIV_EXIT_PRIVERR, _("apply capabilities"));
 	}
 
+	if (opts.ambient_caps) {
+		do_caps(CAP_TYPE_AMBIENT, opts.ambient_caps);
+	}
+
 	execvp(argv[optind], argv + optind);
 
 	err(EXIT_FAILURE, _("cannot execute: %s"), argv[optind]);
-- 
2.13.1

