Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45806 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab1JJNCg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 09:02:36 -0400
Date: Mon, 10 Oct 2011 15:02:32 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] build-sys and lsblk enhancements
Message-ID: <20111010130232.GC17242@nb.net.home>
References: <CAG27Bk0ACb_sAmTiBaEpGRxgeVDJ7-tWhx9N9Ok47ZE3bTD4Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0ACb_sAmTiBaEpGRxgeVDJ7-tWhx9N9Ok47ZE3bTD4Zg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 05, 2011 at 10:42:38PM +0200, Sami Kerola wrote:
>  autogen.sh               |    1 +
>  configure.ac             |   34 ++++++++++++++++++++++++++++++++++
>  include/c.h              |    4 ++--
>  libmount/src/tab_parse.c |   20 +++++++++++++++++++-
>  misc-utils/lsblk.8       |    9 +++++++++
>  misc-utils/lsblk.c       |   12 ++++++++++++
>  6 files changed, 77 insertions(+), 3 deletions(-)

 Applied (with some changes), thanks.

> +if test "x$scanf_cv_type_modifier" = "xms"; then
> +  AC_MSG_RESULT([yes])
> +  AC_DEFINE([HAVE_SCANF_MS_MODIFIER], [1], [scanf %ms modifier])
> +else
> +  if test "x$scanf_cv_type_modifier" = "xas"; then
> +    AC_MSG_RESULT([yes])
> +    AC_DEFINE([HAVE_SCANF_AS_MODIFIER], [1], [scanf %as modifier])
> +  else
> +    build_libmount=no
> +    AC_MSG_RESULT([no])
> +  fi
> +fi

 It usually more readable to use "case .. esac".

 [...]

> +#ifdef HAVE_SCANF_MS_MODIFIER
>  	rc = sscanf(s,	"%ms "	/* (1) source */
>  			"%ms "	/* (2) target */
>  			"%ms "	/* (3) FS type */
>  			"%ms "  /* (4) options */
> +#elif defined(HAVE_SCANF_AS_MODIFIER)
> +	rc = sscanf(s,	"%as "	/* (1) source */
> +			"%as "	/* (2) target */
> +			"%as "	/* (3) FS type */
> +			"%as "  /* (4) options */
> +#endif

 I have add UL_SCNsA macro with %{ms,as} modifiers to c.h, so we don't 
 have to use #ifdef everywhere.

 [...]

> +static void check_sysdevblock(void)
> +{
> +	DIR *dir;
> +	if (!(dir = opendir(_PATH_SYS_DEVBLOCK)))
> +		err(EXIT_FAILURE, _("failed to open sysfs directory: %s"),
> +		    _PATH_SYS_DEVBLOCK);
> +	closedir(dir);
> +	return;
> +}

 access() should be enough :-)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
