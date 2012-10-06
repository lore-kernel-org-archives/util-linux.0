Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56290 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2JFJ6r (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Oct 2012 05:58:47 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so1689575qch.19
        for <util-linux@vger.kernel.org>; Sat, 06 Oct 2012 02:58:46 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 6 Oct 2012 10:58:46 +0100
Message-ID: <CAMU1PDjWg3AG+V86MmDUC7X-+_DbHhxda_fMSqL9P-do4wC6uA@mail.gmail.com>
Subject: bug: blkid doesn't notice when fs labels change to blank
From: Mike Fleetwood <mike.fleetwood@googlemail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

When the label of a file system is changed from something to blank,
blkid doesn't recognise that change.

Test case:

# mkfs.ext4 -L test_label /dev/sda15
# blkid /dev/sda15
/dev/sda15: LABEL="test_label"
UUID="81d5f9cf-01eb-4861-b284-ea4fa4e92a3f" TYPE="ext4"
# tune2fs -L '' /dev/sda15
# tune2fs -l /dev/sda15 | grep 'Filesystem volume name'
Filesystem volume name:   <none>
# blkid /dev/sda15
/dev/sda15: LABEL="test_label"
UUID="81d5f9cf-01eb-4861-b284-ea4fa4e92a3f" TYPE="ext4

This seems true regardless of the file system type used.

Thanks,
Mike
