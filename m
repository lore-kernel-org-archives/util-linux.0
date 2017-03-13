Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbdCMM6T (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 08:58:19 -0400
Date: Mon, 13 Mar 2017 13:58:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/13] blkid: add messages to translations
Message-ID: <20170313125816.wwwt75ptnkh5ey2p@ws.net.home>
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-7-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170305205232.24030-7-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 05, 2017 at 08:52:25PM +0000, Sami Kerola wrote:
>  	while ((c = getopt (argc, argv,
> @@ -721,39 +724,38 @@ int main(int argc, char **argv)
>  			else if (!strcmp(optarg, "full"))
>  				output_format = 0;
>  			else {
> -				fprintf(stderr, "Invalid output format %s. "
> +				errx(BLKID_EXIT_OTHER, _("Invalid output format %s. "
>  					"Choose from value,\n\t"
> -					"device, list, udev or full\n", optarg);
> -				exit(BLKID_EXIT_OTHER);
> +					"value, device, list, udev, export, or full"), optarg);
>  			}
>  			break;
>  		case 'O':
> -			offset = strtosize_or_err(optarg, "invalid offset argument");
> +			offset = strtosize_or_err(optarg, _("invalid offset argument"));
>  			break;
>  		case 'p':
>  			lowprobe |= LOWPROBE_SUPERBLOCKS;
>  			break;
>  		case 's':
>  			if (numtag + 1 >= sizeof(show) / sizeof(*show)) {
> -				fprintf(stderr, "Too many tags specified\n");
> +				warnx(_("Too many tags specified"));
>  				usage(err);

 Ah, it seems blkid is one of the remaining tools where I have no
 changed usage(err) to errtryh(err).

 We don't want to print all usage() on errors, it's better to see
 
    Try 'blkid -h' for more information.

 only.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
