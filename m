Return-Path: dave@gnu.org
Subject: [PATCH] prlimit: use xalloc libs
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 12:58:16 +0100
Message-ID: <1324382296.3316.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index c785909..8235eb1 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -452,7 +452,7 @@ static int parse_prlim(struct rlimit *lim, char *ops, size_t id)
 
 static int add_prlim(char *ops, struct list_head *lims, size_t id)
 {
-	struct prlimit *lim = calloc(1, sizeof(*lim));
+	struct prlimit *lim = xcalloc(1, sizeof(*lim));
 
 	INIT_LIST_HEAD(&lim->lims);
 	lim->desc = &prlimit_desc[id];
-- 
1.7.4.1
