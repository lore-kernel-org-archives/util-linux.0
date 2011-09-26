Return-Path: dave@gnu.org
Subject: [PATCH 2/5] lomount: avoid data duplication
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1317066156.3401.1.camel@offbook>
References: <1317066156.3401.1.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 16:50:00 -0300
Message-ID: <1317066600.2896.2.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 26 Sep 2011 14:57:13 -0300

In lib/loopdev.c we already define struct loop_info64 and the LO_FLAGS_* macros, so get rid of the local ones in loop.h

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/loop.h |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/mount/loop.h b/mount/loop.h
index 64df339..1700983 100644
--- a/mount/loop.h
+++ b/mount/loop.h
@@ -25,13 +25,6 @@
 /* #define LOOP_CHANGE_FD	0x4C06 */
 #define LOOP_SET_CAPACITY	0x4C07
 
-/* Flags for loop_into{64,}->lo_flags */
-enum {
-	LO_FLAGS_READ_ONLY  = 1,
-	LO_FLAGS_USE_AOPS   = 2,
-	LO_FLAGS_AUTOCLEAR  = 4, /* New in 2.6.25 */
-};
-
 #define LO_NAME_SIZE	64
 #define LO_KEY_SIZE	32
 
@@ -50,20 +43,4 @@ struct loop_info {
 	char		reserved[4];
 };
 
-struct loop_info64 {
-	uint64_t	lo_device;
-	uint64_t	lo_inode;
-	uint64_t	lo_rdevice;
-	uint64_t	lo_offset;
-	uint64_t	lo_sizelimit; /* bytes, 0 == max available */
-	uint32_t	lo_number;
-	uint32_t	lo_encrypt_type;
-	uint32_t	lo_encrypt_key_size;
-	uint32_t	lo_flags;
-	uint8_t		lo_file_name[LO_NAME_SIZE];
-	uint8_t		lo_crypt_name[LO_NAME_SIZE];
-	uint8_t		lo_encrypt_key[LO_KEY_SIZE];
-	uint64_t	lo_init[2];
-};
-
 #endif /* MNT_LOOP_H */
-- 
1.7.4.1
