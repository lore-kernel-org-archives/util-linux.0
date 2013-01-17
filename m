Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
	<87fw27jq29.fsf_-_@xmission.com>
	<201301111845.16591.vapier@gentoo.org>
	<20130114082846.GA16421@x2.net.home> <87a9s8lkbq.fsf_-_@xmission.com>
Date: Wed, 16 Jan 2013 16:34:44 -0800
In-Reply-To: <87a9s8lkbq.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Wed, 16 Jan 2013 16:33:29 -0800")
Message-ID: <87y5fsk5p7.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 2/5] nsenter: Properly spell significant in a comment.
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 sys-utils/nsenter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index ad01355..d7d65f9 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -63,7 +63,7 @@ static struct namespace_file{
 	char *name;
 	int fd;
 } namespace_files[] = {
-	/* Careful the order is signifcant in this array.
+	/* Careful the order is significant in this array.
 	 *
 	 * The user namespace comes first, so that it is entered
 	 * first.  This gives an unprivileged user the potential to
-- 
1.7.5.4
