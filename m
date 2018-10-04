Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDRDs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 4 Oct 2018 13:03:48 -0400
Date: Thu, 4 Oct 2018 12:11:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] unshare: allow to set a new root
Message-ID: <20181004101112.2542qy4di4sykelp@ws.net.home>
References: <20180928124512.13979-1-laurent@vivier.eu>
 <20180928124512.13979-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928124512.13979-2-laurent@vivier.eu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 28, 2018 at 02:45:11PM +0200, Laurent Vivier wrote:
> +	if (newroot) {
> +		if (chroot(newroot) != 0)
> +			err(EXIT_FAILURE,
> +			    _("cannot change root directory to '%s'"), newroot);
> +		if (chdir(newdir))
> +			err(EXIT_FAILURE, _("cannot chdir to '%s'"), newdir);
> +	}

It means that --wd is usable only when --root is specified. Is it
expected? Would be better to use

 char *newdir = NULL;

 while ((c = getopt_long(....))) {
    ...
    case 'w':
        newdir = optarg;
        break;
 }
 ...

 if (newroot) {
    if (chroot(newroot))
        ... error ...
    if (chdir(newdir ? newdir : "/"))
        ... error ...

 } else if (newdir && chdir(newdir))
    ... error ...


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
