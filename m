Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/6] lscpu: fix typo in summary output
Date: Wed, 22 Jun 2016 09:25:56 +0200
In-Reply-To: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1466580361-23435-2-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The new drawer support did have a type in the summary output:
it reported Drawers(s) instead of Drawer(s). Fix this.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c                           | 2 +-
 tests/expected/lscpu/lscpu-s390-lpar-drawer | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 41316ccafeec..c07b9d09683a 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1696,7 +1696,7 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			if (desc->ndrawers) {
 				print_n(_("Book(s) per drawer:"),
 					books_per_drawer ?: desc->nbooks / desc->ndrawers);
-				print_n(_("Drawers(s):"), drawers ?: desc->ndrawers);
+				print_n(_("Drawer(s):"), drawers ?: desc->ndrawers);
 			} else {
 				print_n(_("Book(s):"), books_per_drawer ?: desc->nbooks);
 			}
diff --git a/tests/expected/lscpu/lscpu-s390-lpar-drawer b/tests/expected/lscpu/lscpu-s390-lpar-drawer
index 1624e73dd3e0..accbff821065 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar-drawer
+++ b/tests/expected/lscpu/lscpu-s390-lpar-drawer
@@ -5,7 +5,7 @@ Thread(s) per core:    1
 Core(s) per socket:    8
 Socket(s) per book:    3
 Book(s) per drawer:    2
-Drawers(s):            4
+Drawer(s):             4
 NUMA node(s):          1
 Vendor ID:             IBM/S390
 Model name:            0
-- 
2.6.6
