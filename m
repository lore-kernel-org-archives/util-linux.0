Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:36419 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab2IHSKH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 8 Sep 2012 14:10:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TAPTn-0002f4-Ot
	for util-linux@vger.kernel.org; Sat, 08 Sep 2012 20:10:04 +0200
Received: from cpe-76-171-221-18.socal.res.rr.com ([76.171.221.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 08 Sep 2012 20:10:03 +0200
Received: from amit.uttam by cpe-76-171-221-18.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 08 Sep 2012 20:10:03 +0200
To: util-linux@vger.kernel.org
From: Amit <amit.uttam@gmail.com>
Subject: Can't figure out how to use =?utf-8?b?bW50X3RhYmxlX2dldF9yb290X2Zz?= from libmount
Date: Sat, 8 Sep 2012 18:07:51 +0000 (UTC)
Message-ID: <loom.20120908T195804-890@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I have a simple program using libmount that simply gets the path of the
root filesystem. I can't seem to get it to work. I always get a
segmentation fault. There is probably something basic that I am missing
but can't figure it out.

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>

#include <libmount.h>

int main(int argc, char *argv[])
{
    struct libmnt_context *cxt;
    struct libmnt_table *tab;
    struct libmnt_fs *fs;

    /* Enable debugging */
    mnt_init_debug(0xffff);

    /* Create new mount context */
    cxt = mnt_new_context();
    if (!cxt)
        printf("Error creating new mount context\n");

    /* A mount table */
    if (mnt_context_get_mtab(cxt, &tab) < 0)
        printf("Error getting mtab\n");

    /* Get the root filesystem */
    if (mnt_table_get_root_fs(tab, &fs) == -1)
        printf("Error getting root fs from mount table\n");

    const char *src = mnt_fs_get_source(fs);

    char *root = mnt_pretty_path(src, NULL);
    printf("root filesystem source (pretty) %s\n", root);

    return 0;
}

