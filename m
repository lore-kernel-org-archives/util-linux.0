Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36177 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbCXWQR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Mar 2015 18:16:17 -0400
Received: by qgf60 with SMTP id 60so1193461qgf.3
        for <util-linux@vger.kernel.org>; Tue, 24 Mar 2015 15:16:16 -0700 (PDT)
Date: Tue, 24 Mar 2015 18:16:15 -0400
From: Dave Reisner <d@falconindy.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix fsck -C {fd} parsing
Message-ID: <20150324221615.GB513@rampage>
References: <5511C286.90500@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5511C286.90500@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 24, 2015 at 09:01:10PM +0100, Stanislav Brabec wrote:
> Both fsck(8) and fsck --help documents progress bar redirection as
> -C {fd}
> 
> This did not work, and only -C{fd} and "-C {fd}" worked.

Perhaps rather than break the existing behavior it might be better to
make the documentation match reality.

Cheers,
dR

> ---
>  disk-utils/fsck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> index 5842da4..817be97 100644
> --- a/disk-utils/fsck.c
> +++ b/disk-utils/fsck.c
> @@ -1471,7 +1471,7 @@ static void parse_argv(int argc, char *argv[])
>  					else
>  						goto next_arg;
>  				} else if (i+1 < argc && *argv[i+1] != '-') {	/* -C <fd> */
> -					progress_fd = string_to_int(argv[i]);
> +					progress_fd = string_to_int(argv[i+1]);
>  					if (progress_fd < 0)
>  						progress_fd = 0;
>  					else {
> -- 
> 2.3.3
> 
> -- 
> Best Regards / S pozdravem,
> 
> Stanislav Brabec
> software developer
> ---------------------------------------------------------------------
> SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
> Lihovarská 1060/12                            tel: +49 911 7405384547
> 190 00 Praha 9                                 fax:  +420 284 084 001
> Czech Republic                                    http://www.suse.cz/
> PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
