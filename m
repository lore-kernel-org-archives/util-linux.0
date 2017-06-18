Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.gmail.hu ([94.199.52.210]:46595 "EHLO mail.gmail.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdFRRqk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 18 Jun 2017 13:46:40 -0400
Received: from filter.gmail.hu (filter.gmail.hu [192.168.0.125])
        by mail.gmail.hu (Postfix) with ESMTP id 86BA519BBC67F
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2017 19:37:44 +0200 (CEST)
Received: from mail.gmail.hu (storage1.gmail.hu [192.168.0.121])
        by mail.gmail.hu (Postfix) with ESMTPA id 9ACFF19BBC4B9
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2017 19:37:43 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sun, 18 Jun 2017 19:37:35 +0200
From: Istvan Gabor <suseuser04@gmail.hu>
To: <util-linux@vger.kernel.org>
Subject: adding new logical partition in cfdisk
Message-ID: <a1a3d4f7ce3c9cc861d96feb4f9f85e7@gmail.hu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dear util-linux users/developers:

I have been using cfdisk for several years
for editing my disks' partitions.

I noticed/read that util-linux after version
~2.23 has been completely rewritten.

Currently I have version 2.28 which comes
with default openSUSE Leap 42.2.

This version doesn't show volume labels
and it doesn't indicate the file systems
on the partitions (eg ext3, ext4).

It would be really nice if these options
could be added back to cfdisk.

There is also a problem I don't know how
to solve. I have a disk with several partitions:

Device           Boot               Start            End        Sectors=20
      Size      Id Type
     /dev/sdd1        *                   2048      104859647     =20
104857600        50G      83 Linux
     /dev/sdd2                       104859648      209717247     =20
104857600        50G      83 Linux
     /dev/sdd3                       209717248      336662877     =20
126945630      60.5G      83 Linux
     /dev/sdd4                       336662878      516333837     =20
179670960      85.7G       5 Extended
     =E2=94=9C=E2=94=80/dev/sdd5                     336662941      3405666=
72       =20
3903732       1.9G      82 Linux swap / Solaris
     =E2=94=9C=E2=94=80/dev/sdd6                     340566736      3991557=
27      =20
58588992        28G      83 Linux
     =E2=94=9C=E2=94=80/dev/sdd7                     399155791      4577447=
82      =20
58588992        28G      83 Linux
     =E2=94=94=E2=94=80/dev/sdd8                     457744846      5163338=
37      =20
58588992        28G      83 Linux
>>  Free space                      516335616      625134190     =20
>> 108798575      51.9G

I would like to add a new logical partition to the
free space. I select/highlight free space, then select
"New".

I set the size of the new partition:
  Partition size: 28G

But cfdisk doesn't create the new partition,
instead it says:
All primary partitions are in use.

How can I add new partition to the free space
using cfdisk?

This worked in cfdisk 2.23.

Thanks,

Istvan

