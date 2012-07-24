Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab2GXK5m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 06:57:42 -0400
Date: Tue, 24 Jul 2012 12:57:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/10] fdisk: API: add error handling
Message-ID: <20120724105736.GA7057@x2.net.home>
References: <1342976698.2863.11.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342976698.2863.11.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 22, 2012 at 07:04:58PM +0200, Davidlohr Bueso wrote:
>  fdisks/fdisk.c                |   35 +++-------------
>  fdisks/fdisk.h                |   33 +++++++++-----
>  fdisks/fdiskaixlabel.c        |    4 +-
>  fdisks/fdiskbsdlabel.c        |   20 +++++-----
>  fdisks/fdiskdoslabel.c        |    4 +-
>  fdisks/fdiskmaclabel.c        |    4 +-
>  fdisks/fdisksgilabel.c        |   12 +++---
>  fdisks/fdisksunlabel.c        |    8 ++--
>  fdisks/utils.c                |   90 ++++++++++++++++++++++++++++++++++-------
>  tests/expected/fdisk/oddinput |    4 +-
>  10 files changed, 131 insertions(+), 83 deletions(-)

 Not applied. I think that we need to follow standard libc error
 handling as much as possible rather than try to reimplement our own
 universe.

> -	cxt = fdisk_new_context_from_filename(argv[optind], 0);
> +	cxt = fdisk_new_context_from_filename(argv[optind], 0, &errcode);
>  	if (!cxt)
> -		err(EXIT_FAILURE, _("cannot open %s"), argv[optind]);
> +		errx(EXIT_FAILURE, _("%s: %s"), fdisk_error_name(errcode), 
> +		    argv[optind]);

 This is exactly why I don't like it. There is errno and err() to
 print details about the error, it's able to follow locales, etc.

 Your FDISK_ERROR_OPEN is too generic and fdisk_error_name() have no
 clue about locales.

 The old err() and errno based implementation is able to provide
 details like:

    cannot open /dev/sda: Permission denied

 or ENOMEM, etc.

 I have fixed the new fdisk API to use errno as much as possible. For
 now it seems that we does not need any extra error handling
 infrastructure... so it will be better to postpone until we found any
 real issue.

 The basic rule is simple, just return -errno, for example:

    if (syscal( .... ) == -1)
        return -errno;

 if no errno is set then use -E<something from man errno> for example:

    if (!cxt)
        return -EINVAL;

 or (and) set the errno. If errno.h stuff is insufficient the we can
 define our own codes (maximum system errno value should be 4095 on UNIXe)
 so we can use values greater than 5000 or so).

 I know that I have talked with David about fdisk_strerror() or so,
 but it's seems like overkill for now. I'd like to avoid error
 messages in the libfdisk library, it's better to use codes and
 compose messages in programs.

> --- a/tests/expected/fdisk/oddinput
> +++ b/tests/expected/fdisk/oddinput
> @@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
>  I/O size (minimum/optimal): 512 bytes / 512 bytes
>  
>  Nonexistant file
> -lt-fdisk: unable to open _a_file_that_does_not_exist_: No such file or directory
> +lt-fdisk: error: cannot open: _a_file_that_does_not_exist_
>  Too small file
> -lt-fdisk: unable to open oddinput.toosmall: Success
> +lt-fdisk: error: cannot read: oddinput.toosmall

 Fixed by errno = EINVAL, the test updated ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
