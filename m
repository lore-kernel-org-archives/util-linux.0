Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:65450 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933479AbcBSLGk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Feb 2016 06:06:40 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MdWO8-1aKXgo0phc-00PNb1 for
 <util-linux@vger.kernel.org>; Fri, 19 Feb 2016 12:06:38 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: again errno usage, today: strutils.c
Date: Fri, 19 Feb 2016 12:06:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201602191206.36635.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

There are many functions in strutils.c where we don't reset errno
before using it. For example this one:

unsigned long strtoul_or_err(const char *str, const char *errmesg)
{
    unsigned long num;
    char *end = NULL;

    if (str == NULL || *str == '\0')
        goto err;
    errno = 0;
    num = strtoul(str, &end, 10);

    if (errno || str == end || (end && *end))
        goto err;

    return num;
err:
    if (errno)
        err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);

    errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
}


You can make the problem visible:

$ ./logger --no-act -t "wtf" --id="XX" message
logger: failed to parse id: 'XX'
$ ./logger --no-act -t "wtf" --id="" message
logger: failed to parse id: '': No such file or directory


It's easy to fix:

+   errno = 0;
    if (str == NULL || *str == '\0')
        goto err;
-   errno = 0;


But I want to ask whether it would be a good idea to make the message 
generally less verbose:

-   if (errno)
+   if (errno == ERANGE)

On other systems strtoul(3p) would return EINVAL too for case --id="XX" 
but EINVAL has no useful information here:

  test_logger: failed to parse id: 'XX': Invalid argument

This would not change anything on Linux/c99 as strtoul(3) only set 
ERANGE there.

Opinions? 

cu,
Rudi
