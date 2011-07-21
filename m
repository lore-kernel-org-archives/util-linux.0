Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab1GUSKQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jul 2011 14:10:16 -0400
Date: Thu, 21 Jul 2011 20:10:12 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] cramfs fixes
Message-ID: <20110721181012.GA6672@nb.net.home>
References: <CAG27Bk1uKnqR62SRNgTXFPGfTseraC0AUgpAMQ5zhdcsAM-79w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1uKnqR62SRNgTXFPGfTseraC0AUgpAMQ5zhdcsAM-79w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2011 at 10:55:16PM +0200, Sami Kerola wrote:
> +	/*
> +	 * NAMELEN is the length of the file name, divided by 4 and
> +	 * rounded up.  (cramfs doesn't support hard links.)
> +	 *
> +	 * OFFSET: For symlinks and non-empty regular files, this
> +	 * contains the offset (divided by 4) of the file data in
> +	 * compressed form (starting with an array of block pointers;
> +	 * see README).  For non-empty directories it is the offset
> +	 * (divided by 4) of the inode of the first file in that
> +	 * directory.  For anything else, offset is zero.
> +	 */
>  	u32 namelen:6, offset:26;
    ^^^
 uint32_t

> +/* Exit codes used by fsck-type programs */
> +#define FSCK_OK			0	/* No errors */
> +#define FSCK_NONDESTRUCT	1	/* File system errors corrected */
> +#define FSCK_REBOOT		2	/* System should be rebooted */
> +#define FSCK_UNCORRECTED	4	/* File system errors left uncorrected */
> +#define FSCK_ERROR		8	/* Operational error */
> +#define FSCK_USAGE		16	/* Usage or syntax error */
> +#define FSCK_LIBRARY		128	/* Shared library error */

 I see magic numbers also in fsck.minix ;-)

 What about to add include/exitcodes.h and move this and
 disk-utils/mkfs.h to this file?

>  		if (size >= page_size) {
> -			if (out != page_size) {
> -				die(FSCK_UNCORRECTED, 0, _("non-block (%ld) bytes"), out);
> -			}
> -		} else {
> -			if (out != size) {
> -				die(FSCK_UNCORRECTED, 0, _("non-size (%ld vs %ld) bytes"), out, size);
> -			}
> -		}
> -		size -= out;
> -		if (opt_extract) {
> -			if (write(fd, outbuffer, out) < 0) {
> -				die(FSCK_ERROR, 1, _("write failed: %s"), path);
> -			}
> +			if (out != page_size)
> +				errx(FSCK_UNCORRECTED,
> +				     _("non-block (%ld) bytes"), out);
> +			else if (out != size)

        } else if (out != size)
       ^^^   

> +				errx(FSCK_UNCORRECTED,
> +				     _("non-size (%ld vs %ld) bytes"), out,
> +				     size);
> +			size -= out;
> +			if (opt_extract)
> +				if (write(fd, outbuffer, out) < 0)
> +					err(FSCK_ERROR, _("write failed: %s"),
> +					    path);
> +			curr = next;
>  		}
       ^^^

the 'if (opt_extract)' block is outsize 'if (size >= page_size)'...

> -		curr = next;
>  	} while (size);
>  }
> -		if ((S_ISUID | S_ISGID) & i->mode) {
> -			if (chmod(path, i->mode) < 0) {
> -				die(FSCK_ERROR, 1, _("chown failed: %s"), path);
> -			}
> -		}
> +		if ((S_ISUID | S_ISGID) & i->mode)
> +			if (chmod(path, i->mode) < 0)
> +				err(FSCK_ERROR, _("chown failed: %s"), path);
>  	}

      if (((S_ISUID | S_ISGID) & i->mode) && chmod(path, i->mode) < 0)
           err(FSCK_ERROR, _("chown failed: %s"), path);

[...]

>  	while ((c = getopt(argc, argv, "hb:Ee:i:n:N:psVvz")) != EOF) {
>  		switch (c) {
>  		case 'h':
> -			usage(0);
> +			usage(MKFS_OK);
>  		case 'b':
> -			blksize = atoi(optarg);
> +			blksize = strtoll_or_err(optarg, _("blocksize argument failed"));

 hmm... "failed to parse blocksize argument" ?

 [...]

>  			else if (strcmp(optarg, "host") == 0);	/* default */
> -			else 	{
> -				perror("invalid endianness given. Must be 'big', 'little', or 'host'");
> -				exit(MKFS_USAGE);
> -			}
> +			else
> +				errx(MKFS_USAGE, _("invalid endianness given."
> +						   " Must be 'big', 'little', or 'host'"));

   else if (strcmp(optarg, "host") == 0)
        ; /* default */
   else {
        ....
   }

>  		case 'V':
>  			printf(_("%s (%s)\n"),

 "%s from %s\n" :-)

> -			       progname, PACKAGE_STRING);
> +			       program_invocation_short_name, PACKAGE_STRING);

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
