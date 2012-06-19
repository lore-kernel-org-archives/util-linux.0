Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26049 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2FSO0a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jun 2012 10:26:30 -0400
Date: Tue, 19 Jun 2012 16:26:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Marcos Felipe Rasia de Mello <marcosfrm@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: lsblk "include" option?
Message-ID: <20120619142627.GA14727@x2.net.home>
References: <CAJZVDJCK3Z_u_2TYrFMdjhjNXAJgW2C9rGnwv4RdEkcca92C7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJZVDJCK3Z_u_2TYrFMdjhjNXAJgW2C9rGnwv4RdEkcca92C7Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 15, 2012 at 10:09:16AM -0300, Marcos Felipe Rasia de Mello wrote:
> lsblk has an "exclude" (-e, --exclude) option. I wonder if would be
> possible to add an "include" option to tell it to show *only*
> specified major number devices. Like
> 
> lsblk -i 8

 Implemented (--include, -I)

> to only print major number 8 devices.

 note that the filters (--exclude and --include) are applied to
 top-level devices only. For example:

 $ lsblk --include 8
 NAME   MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
 sda      8:0    0 149.1G  0 disk  
 ├─sda1   8:1    0  1000M  0 disk  /boot/efi
 ├─sda2   8:2    0     2G  0 disk  /boot
 ├─sda3   8:3    0   9.7G  0 disk  [SWAP]
 ├─sda4   8:4    0  34.2G  0 disk  /
 ├─sda5   8:5    0  63.2G  0 disk  /home
 └─sda6   8:6    0  39.1G  0 disk  
   └─luks-10d813de-fa82-4f67-a86c-23d5d0e7c30e (dm-0)
          253:0    0  39.1G  0 crypt /home/kzak


I have a little changed --all option, it's not mutually exclusive to
--include and --exclude anymore. The idea is to print all devices
including empty devices (empty devices are ignored by default), for
example:

$ lsblk --all --include 7
NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
loop0   7:0    0       0 loop 
loop1   7:1    0       0 loop 
loop2   7:2    0       0 loop 
loop3   7:3    0       0 loop 
loop4   7:4    0       0 loop 
loop5   7:5    0       0 loop 
loop6   7:6    0       0 loop 
loop7   7:7    0       0 loop 


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
