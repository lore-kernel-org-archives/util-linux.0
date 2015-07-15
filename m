Return-Path: vadim4j@gmail.com
Date: Wed, 15 Jul 2015 18:09:49 +0300
From: Vadim Kochan <vadim4j@gmail.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: GPT writing of unknown partition uuids
Message-ID: <20150715150949.GA28525@angus-think.wlc.globallogic.com>
References: <alpine.DEB.2.02.1507141610310.21273@brickies>
 <20150715134234.GC31997@ws.net.home>
 <alpine.DEB.2.02.1507151055540.30147@brickies>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1507151055540.30147@brickies>
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 15, 2015 at 10:56:48AM -0400, Scott Moser wrote:
> On Wed, 15 Jul 2015, Karel Zak wrote:
> 
> > On Tue, Jul 14, 2015 at 04:16:56PM -0400, Scott Moser wrote:
> > > It seems like if the user provided you with a GUID, sfdisk should trust
> > > them, or at very least exit failure if it refuses to use the provided
> > > GUID.
> > >
> > > Thoughts?
> >
> > It's bug, the "unknown" partition type is expected. Fixed in git tree:
> >
> > # sfdisk -ql /dev/sdc
> > Device     Start     End Sectors  Size Type
> > /dev/sdc1   2048 1023966 1021919  499M Linux filesystem
> >
> >
> > # sfdisk --part-type /dev/sdc 1 $(uuidgen)
> > ...
> >
> >
> > # sfdisk -ql /dev/sdc
> > Device     Start     End Sectors  Size Type
> > /dev/sdc1   2048 1023966 1021919  499M unknown
> >
> >
> > Thanks for your report!
> Thanks for the quick fix.
> 
> Is it sane for me to assume this is fixed in any version of
>   util-linux > 2.26.2 ?
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Would you please test a following fix ?

diff --git a/misc/ss.c b/misc/ss.c
index 03f92fa..3a826e4 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -683,8 +683,8 @@ static inline void sock_addr_set_str(inet_prefix *prefix, char **ptr)
 
 static inline char *sock_addr_get_str(const inet_prefix *prefix)
 {
-    char *tmp ;
-    memcpy(&tmp, prefix->data, sizeof(char *));
+    char *tmp;
+    memcpy(&tmp, &prefix->data[0], sizeof(char *));
     return tmp;
 }
 
