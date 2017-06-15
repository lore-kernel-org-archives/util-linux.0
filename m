Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdFOXoI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Jun 2017 19:44:08 -0400
Subject: [PATCH 05/10] parse-date: use uintmax_t where appropriate
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <e7689962-9c30-6dad-1dc2-7ed4f1932543@gmx.com>
Date: Thu, 15 Jun 2017 19:43:52 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index b79b333..a8f710c 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -1061,7 +1061,7 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 		if (c_isdigit (c) || c == '-' || c == '+') {
 			char const *p;
 			int sign;
-			unsigned long int value;
+			uintmax_t value;
 			if (c == '-' || c == '+') {
 				sign = c == '-' ? -1 : 1;
 				while (c = *++pc->input, c_isspace (c))
@@ -1073,21 +1073,21 @@ static int yylex (union YYSTYPE *lvalp, parser_control *pc)
 				sign = 0;
 			p = pc->input;
 			for (value = 0; ; value *= 10) {
-				unsigned long int value1 = value + (c - '0');
+				uintmax_t value1 = value + (c - '0');
 				if (value1 < value)
 					return '?';
 				value = value1;
 				c = *++p;
 				if (! c_isdigit (c))
 					break;
-				if (ULONG_MAX / 10 < value)
+				if (UINTMAX_MAX / 10 < value)
 					return '?';
 			}
 			if ((c == '.' || c == ',') && c_isdigit (p[1])) {
 				time_t s;
 				int ns;
 				int digits;
-				unsigned long int value1;
+				uintmax_t value1;
 
 				/* Check for overflow when converting value to
 				 * time_t.
