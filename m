Return-Path: dave@gnu.org
Subject: [PATCH] prlimit: return proper type
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Dec 2011 21:19:19 +0100
Message-ID: <1323375559.2562.2.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

The add_prlim() function's definition currently returns a bogus structure.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index ae5453b..c785909 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -450,7 +450,7 @@ static int parse_prlim(struct rlimit *lim, char *ops, size_t id)
 	return found;
 }
 
-static struct prlimit *add_prlim(char *ops, struct list_head *lims, size_t id)
+static int add_prlim(char *ops, struct list_head *lims, size_t id)
 {
 	struct prlimit *lim = calloc(1, sizeof(*lim));
 
-- 
1.7.4.1
