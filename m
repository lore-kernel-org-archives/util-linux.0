Return-Path: elseifthen@gmx.com
Subject: [PATCH 06/10] parse-date: use to_uchar() instead of assignment.
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c74836f4-3d03-9d29-beea-08e08b4b1aa3@gmx.com>
Date: Thu, 15 Jun 2017 19:45:05 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index a8f710c..620626e 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -990,10 +990,8 @@ static table const * lookup_word(parser_control const *pc, char *word)
 	int abbrev;
 
 	/* Make it uppercase. */
-	for (p = word; *p; p++) {
-		unsigned char ch = *p;
-		*p = c_toupper (ch);
-	}
+	for (p = word; *p; p++)
+		*p = c_toupper (to_uchar (*p));
 
 	for (tp = meridian_table; tp->name; tp++)
 		if (strcmp (word, tp->name) == 0)
