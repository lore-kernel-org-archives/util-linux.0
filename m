Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2FKJs4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jun 2012 05:48:56 -0400
Date: Mon, 11 Jun 2012 11:48:51 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] require C99, add robustness and small fixes
Message-ID: <20120611094851.GA21893@x2.net.home>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 10, 2012 at 11:11:34PM +0200, Sami Kerola wrote:
> diff --git a/configure.ac b/configure.ac
> index 2280e7e..13c9637 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -80,6 +80,24 @@ AC_CANONICAL_HOST
>  AC_C_CONST
>  AC_C_VOLATILE
>  AC_C_BIGENDIAN
> +if test "$cross_compiling" = no; then
> +  if test "x$ac_cv_prog_cc_c99" = "xno" || test "x$ac_cv_prog_cc_c99"
> = "x"; then
> +  # We might be on RHEL5 with a git checkout and so broken
> +  # autoconf. Check if CC is gcc and if it bails when given -std=gnu99.
> +  # If not, use that.  Yuck.
> +    if test "x$ac_cv_c_compiler_gnu" = "xyes"; then
> +       CC="$CC -std=gnu99"
> +       AC_RUN_IFELSE(
> +          [AC_LANG_PROGRAM([],[[
> +  return 0;
> +      ]])],
> +      [],
> +      [AC_MSG_ERROR([Could not find a C99 compatible compiler])])
> +    else
> +      AC_MSG_ERROR([Could not find a C99 compatible compiler])
> +    fi
> +  fi
> +fi

 AC_PROG_CC_C99 sounds really like a better solution, although I have
 autoconf 2.68 on Fedora 16 :-(

> --- a/misc-utils/blkid.c
> +++ b/misc-utils/blkid.c
> @@ -365,8 +365,10 @@ static int append_str(char **res, size_t *sz,
> const char *a, const char *b)
>  		return -1;
> 
>  	str = realloc(str, len + 1);
> -	if (!str)
> +	if (!str) {
> +		free(res);

        free(*res);

>  		return -1;
> +	}
> 
>  	*res = str;
>  	str += *sz;
> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
> index 9e894ef..f9e05b6 100644
> --- a/misc-utils/lsblk.c
> +++ b/misc-utils/lsblk.c
> @@ -527,6 +527,12 @@ static char *get_type(struct blkdev_cxt *cxt)
>  				type = "mo-disk"; break;
>  			case 0x0e: /* TYPE_RBC */
>  				type = "rbc"; break;
> +			default:
> +				/* Perhaps include/scsi/scsi.h in
> +				 * kernel git section 'DEVICE TYPES'
> +				 * will know what was found.  */
> +				sprintf(type, "0x%02x", x);
> +				break;

 What about to add scsi_type_to_name() to lib/blkdev.c and add
 SCSI_TYPE_* macros (TYPE_* sounds too generic) to include/blkdev.h
 with fallbacks for too old /usr/include/scsi/scsi.h files.

 ...

> +static void set_exclusive(int *what, int how)
> +{
> +	if (*what == ACT_NONE) {
> +		*what = how;
> +		return;
> +	}
> +	if (*what == how)
> +		return;
> +	errx_mutually_exclusive("--{add,delete,show,list,raw,pairs}");
> +}

 This is good idea, I guess we have the same problem on more places
 where is the "mutually exclusive" error message.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
