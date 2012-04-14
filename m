Return-Path: dave@gnu.org
Subject: [PATCH] prlimit: remove bogus instructions
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 14 Apr 2012 12:01:03 +0200
Message-ID: <1334397663.2564.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

usage() is noreturn!

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 12271a0..7e52a2d 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -585,7 +585,6 @@ int main(int argc, char **argv)
 			break;
 		case 'h':
 			usage(stdout);
-			break;
 		case 'o':
 			ncolumns = string_to_idarray(optarg,
 						     columns, ARRAY_SIZE(columns),
@@ -609,7 +608,6 @@ int main(int argc, char **argv)
 
 		default:
 			usage(stderr);
-			break;
 		}
 	}
 	if (argc > optind && pid)
-- 
1.7.4.1
