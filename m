Return-Path: samuel.thibault@ens-lyon.org
Date: Thu, 11 Apr 2013 00:43:27 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] fix non-linux build (was: [ANNOUNCE] util-linux v2.23-rc2)
Message-ID: <20130410224327.GK17173@type.leflore.lan>
References: <20130410222248.GF26442@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <20130410222248.GF26442@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Make enabling fdformat depend on being a linux build.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/configure.ac b/configure.ac
index dd5d3e1..d9d6cb8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -968,7 +968,7 @@ AM_CONDITIONAL(BUILD_BFS, test "x$build_bfs" = xyes)
 
 AC_ARG_ENABLE([fdformat],
   AS_HELP_STRING([--disable-fdformat], [do not build fdformat]),
-  [], enable_fdformat=yes
+  [], enable_fdformat=check
 )
 UL_BUILD_INIT([fdformat])
 UL_REQUIRES_LINUX([fdformat])

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/configure.ac b/configure.ac
index dd5d3e1..d9d6cb8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -968,7 +968,7 @@ AM_CONDITIONAL(BUILD_BFS, test "x$build_bfs" = xyes)
 
 AC_ARG_ENABLE([fdformat],
   AS_HELP_STRING([--disable-fdformat], [do not build fdformat]),
-  [], enable_fdformat=yes
+  [], enable_fdformat=check
 )
 UL_BUILD_INIT([fdformat])
 UL_REQUIRES_LINUX([fdformat])

--SLDf9lqlvOQaIe6s--
