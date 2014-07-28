Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbaG1L5V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 07:57:21 -0400
Date: Mon, 28 Jul 2014 13:56:30 +0200
From: Karel Zak <kzak@redhat.com>
To: bobtfish@bobtfish.net
Cc: util-linux@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] Setting uid / gid is generally useful in nseneter
Message-ID: <20140728115630.GJ8533@x2.net.home>
References: <1406406174-20938-1-git-send-email-bobtfish@bobtfish.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406406174-20938-1-git-send-email-bobtfish@bobtfish.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 26, 2014 at 01:22:54PM -0700, bobtfish@bobtfish.net wrote:
> It's useful to be able to set the UID/GID even when not using user namespaces
> (for example when creating a non-root shell in a pre-existing docker container)
> 
> Signed-off-by: Tomas Doran <bobtfish@bobtfish.net>
> ---
>  sys-utils/nsenter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
> index d57edc8..23798f9 100644
> --- a/sys-utils/nsenter.c
> +++ b/sys-utils/nsenter.c
> @@ -328,7 +328,7 @@ int main(int argc, char *argv[])
>  	if (do_fork == 1)
>  		continue_as_child();
>  
> -	if (namespaces & CLONE_NEWUSER) {
> +	if (uid > 0 || gid > 0) {

 Well, it breaks the current behavior (the default for CLONE_NEWUSER
 is UID=0 and GID=0).


 The question is this is the right direction, because I guess that the next 
 patch for nsenter(1) will be "please, add supplementary groups support" ;-)

 Maybe the best will be to add to su(1) support for namespaces, something 
 like:

   su --ns <pid>[:mount,uts,ipc,net,pid,user]

 to enter namespaces after authenticate (if required) and before
 identity change. Not sure how huge is this Pandora's box, but it's
 definitely the final solution for all the requirements, because su(1)
 already supports all the UID/GID related features.

 Eric, any note?

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
