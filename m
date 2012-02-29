Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10665 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755293Ab2B2PoW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Feb 2012 10:44:22 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1TFiM1h021941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 29 Feb 2012 10:44:22 -0500
Received: from x2 (ovpn-116-18.ams2.redhat.com [10.36.116.18])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q1TFiLud027371
	for <util-linux@vger.kernel.org>; Wed, 29 Feb 2012 10:44:21 -0500
Date: Wed, 29 Feb 2012 16:44:20 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.22 wish list
Message-ID: <20120229154420.GD8471@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


This is my v2.22 wish list. The list contains large/invasive tasks only. 
Comments, volunteers, .... ? ;-)

 * release in May/Jun 2012

 * add PARTUUID= and PARTLABEL= support to mount/fsck by partition UUID/LABEL
   - add to libblkid blkid_evaluate_* API
   - support in libmount 
   - add regression tests

 * make uuidd (uuid daemon) compatible with systemd
   - add --no-fork
   - add --no-pid (pid file)
   - add systemd unit file
   - add #ifdef LIBUUID_EXEC_UUIDD to disable uuidd exec from library

 * fdisk
   - move mbr (dos) stuff to fdiskmbrlabel.c
   - add GPT support

 * clean up DBG() macro in libblkid
   - see libmount version

 * add dasd support to libblkid

 * non-recursive build-system (now many files from lib/ are compileted 
   more than once), see:
   http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297

 * merge reject
   Michal L. is working on this task
   https://github.com/mluscon/util-linux/tree/eject

 * ???


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
