Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab2DJLcS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 07:32:18 -0400
Date: Tue, 10 Apr 2012 13:31:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>, Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH 3/3] libuuid: use randutils
Message-ID: <20120410113150.GN19784@x2.net.home>
References: <1333662730.2696.6.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333662730.2696.6.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 11:52:10PM +0200, Davidlohr Bueso wrote:
>  libuuid/src/Makefile.am |    3 +-
>  libuuid/src/gen_uuid.c  |   99 ++--------------------------------------------
>  2 files changed, 7 insertions(+), 95 deletions(-)

 Applied, thanks.

> @@ -703,7 +614,7 @@ void uuid_generate_random(uuid_t out)
>   */
>  void uuid_generate(uuid_t out)
>  {
> -	if (get_random_fd() >= 0)
> +	if (random_get_fd() >= 0)
>  		uuid_generate_random(out);

This sucks:

 - because we call random_get_fd() in __uuid_generate_random again:

   $ strace -e open ./misc-utils/uuidgen
   open("/dev/urandom", O_RDONLY)          = 3
   open("/dev/urandom", O_RDONLY)          = 4

   it would be better to add 'fd' argument to __uuid_generate_random(),
   use it in uuid_generate() and reuse the file descriptor if >= 0. 

   We use __uuid_generate_random in the library and in uuidd, so we
   don't have to care about API there.

 - it's file descriptor leak in shared library...

 Volunteers? ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
