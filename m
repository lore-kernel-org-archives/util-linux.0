Return-Path: dave@gnu.org
Subject: [PATCH 1/2] fdisk: API: fix fdisk_add_partition comment style
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jul 2012 14:40:03 +0200
Message-ID: <1343133603.2686.15.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/utils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index bf58d5b..8de64c2 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -83,7 +83,7 @@ int fdisk_verify_disklabel(struct fdisk_context *cxt)
 	return cxt->label->verify(cxt);
 }
 
-/*
+/**
  * fdisk_add_partition:
  * @cxt: fdisk context
  * @partnum: partition number to create
-- 
1.7.4.1
