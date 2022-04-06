Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B9DC433EF
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiDFRHD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiDFRGu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 13:06:50 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 07:30:13 PDT
Received: from correo.48k.eu (correo.48k.eu [217.70.190.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B24181FD2D6
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 07:30:12 -0700 (PDT)
Received: from [192.168.1.147] (unknown [78.30.58.132])
        by correo.48k.eu (Postfix) with ESMTPSA id 0FB7246257
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 16:23:21 +0200 (CEST)
Message-ID: <f0103dd3-870c-5ece-7490-12d927cdaefd@soleta.eu>
Date:   Wed, 6 Apr 2022 16:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   "Jose M. Guisado" <jguisado@soleta.eu>
To:     util-linux@vger.kernel.org
Subject: libfdisk python bindings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi, recently I've started working on python bindings for libfdisk. Just
a C extension for CPython, like the libmount python bindings.

Early WIP can be found at https://github.com/pvxe/python-libfdisk/

After reading the mailing list archive and previous github issues
related to python bindings, I'm wondering if patches would be accepted,
or python bindings are preferred separate from the util-linux tree.

As of now, I'm only using these bindings to fetch label information and
partition fields using fdisk_partition_to_string. But the idea is also
being able to modify the partition table in the future.

  >>> import fdisk
  >>> cxt = fdisk.Context(device="/dev/sda")
  >>> cxt.label
  <libfdisk.Label object at 0x7f609a8e4f90, name=gpt>
  >>> l = cxt.label
  >>> l.
  l.name  l.type
  >>> l.name
  'gpt'
  >>> l.type
  32
  >>> cxt.nsectors
  3907029168
  >>> cxt.sector_size
  512
  >>> cxt.parts
  [<libfdisk.Partition object at 0x7f8f69f64fb0>,
   <libfdisk.Partition object at 0x7f8f69f64fd0>]
  >>> p = cxt.parts[1]
  >>> cxt.partition_to_string(p, fdisk.FDISK_FIELD_FSTYPE)
  'LVM2_member'


Regards,
Jose
