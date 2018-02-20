Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbeBTHTL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Feb 2018 02:19:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55FC6402290A
        for <util-linux@vger.kernel.org>; Tue, 20 Feb 2018 07:19:11 +0000 (UTC)
Date: Tue, 20 Feb 2018 16:19:09 +0900 (JST)
Message-Id: <20180220.161909.2152980892049665100.yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: RFC: watchdog
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

As far as I know, there is no enough popular tool to inspect the
current status of /dev/watchdog. watchdog device provides ioctl
commands to return timeout value and timeleft value. The tool
I assume is reports the values for given device.

/sys/class/watchdog is provided. However, whether it
is available or not is up to kernel build-configuration.

How do you think about adding such tool to util-linux?
Do you think such command should be in a separate project?
If the answer is yes, what command name do you prefer to for
the command? ("watchdog" is not good name).

If the answer is no, could you tell me a project or person
I should talk to about this command?

I attached a prototype.

Masatake YAMATO

/* catdog.c
 * No copyright is claimed.  This code is in the public domain; do with
 * it what you wish. */

#include <stdio.h>
#include <stdlib.h>
#include <error.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/watchdog.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

static void
usage(char *program, int status, FILE *fp)
{
	fprintf(fp, "Usage: ");
	fprintf(fp, "	%s DEVICE", program);
	exit(status);
}

int
main(int argc, char **argv)
{
	if (argc < 2)
		usage(argv[0], 1, stderr);
	int fd;

	if (strcmp(argv[1], "-h") == 0
	    || strcmp(argv[1], "-?") == 0
	    || strcmp(argv[1], "--help") == 0)
		usage(argv[0], 0, stdout);

	/* TODO: Check the major number */
	fd = open(argv[1], O_RDONLY);
	if (fd < 0)
		error(1, errno, "cannot open the watchdog device: %s", argv[1]);

	int p = 0;
	unsigned int q;
	if (ioctl(fd, WDIOC_GETSTATUS, &q) < 0)
		perror ("Error in GETSTATUS");
	else
		printf("BOOTSTATUS: %u\n", q);

	if (ioctl(fd, WDIOC_GETBOOTSTATUS, &p) < 0)
		perror ("Error in GETBOOTSTATUS");
	else
		printf("BOOTSTATUS: %d\n", p);	

	if (ioctl(fd, WDIOC_GETTIMEOUT, &p) < 0)
		perror ("Error in GETTIMEOUT");
	else
		printf("TIMEOUT: %d\n", p);

	if (ioctl(fd, WDIOC_GETTIMELEFT, &p) < 0)
		perror ("Error in GETTIMELEFT");
	else
		printf("TIMELEFT: %d\n", p);

	return 0;
}
