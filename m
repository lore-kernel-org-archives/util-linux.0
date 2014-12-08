Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbaLHMVO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Dec 2014 07:21:14 -0500
Date: Mon, 8 Dec 2014 13:21:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/10] ipcs: fix two data type errors [AddressSanitizer]
Message-ID: <20141208122102.GF19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-11-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417355862-16935-11-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 30, 2014 at 01:57:42PM +0000, Sami Kerola wrote:
> ==3218==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fffa577e2b0 at pc 0x4501f9 bp 0x7fffa577e130 sp 0x7fffa577e108
> WRITE of size 112 at 0x7fffa577e2b0 thread T0
>     #0 0x4501f8 in shmctl /home/users/aadgrand/LLVM/releases/ubuntu/final/llvm.src/projects/compiler-rt/lib/sanitizer_common/sanitizer_common_interceptors.inc:2502
>     #1 0x48bd13 in ipc_shm_get_info /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcutils.c:157
>     #2 0x488884 in do_shm /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:279
>     #3 0x4844a8 in main /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:175
>     #4 0x2afb3f8c176c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
>     #5 0x48408c in _start (/home/travis/build/kerolasa/lelux-utiliteetit/ipcs+0x48408c)
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/ipcutils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
> index c45162a..3d5249c 100644
> --- a/sys-utils/ipcutils.c
> +++ b/sys-utils/ipcutils.c
> @@ -98,7 +98,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
>  	FILE *f;
>  	int i = 0, maxid;
>  	struct shm_data *p;
> -	struct shm_info dummy;
> +	struct shmid_ds dummy;
>  
>  	p = *shmds = xcalloc(1, sizeof(struct shm_data));
>  	p->next = NULL;
> @@ -154,7 +154,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
>  
>  	/* Fallback; /proc or /sys file(s) missing. */
>  shm_fallback:
> -	maxid = shmctl(0, SHM_INFO, (struct shmid_ds *) &dummy);
> +	maxid = shmctl(0, SHM_INFO, &dummy);

 ipc_shm_get_limits() is also broken

 The function shmctl() has to be always called with "struct shmid_ds"
 and then cast to linux specific shmid_info struct.

 It would be nice to check that all the shm/sem/msgctl functions are
 really called with proper arguments.

 (Or we can define any union and use it as buffer to make sure that
  the argument is large enough.)

 BTW, horrible API (or I need more coffee to understand this art).


    Karel
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
