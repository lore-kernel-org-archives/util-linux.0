Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab2I0MDV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Sep 2012 08:03:21 -0400
Date: Thu, 27 Sep 2012 14:03:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] fdisk: add GPT support
Message-ID: <20120927120314.GB18644@x2.net.home>
References: <1345550602.2664.6.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345550602.2664.6.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 21, 2012 at 02:03:22PM +0200, Davidlohr Bueso wrote:
> This patch allows fdisk to handle GUID partition tables, based on
> the latest UEFI specifications version 2.3.1, from June 27th, 2012.

 Applied, with some changes (add string based list of partition
 types).

 TODO:

    - differentiate between number of allocated and used partitions in GPT,
      for example "Partition number (1-128):" dialog is strange if you have
      only one partition. [I'll fix it tomorrow]

    - add 'Device' column to GPT list_table output [I'll fix it tomorrow]

    - add 'g' to main menu to create a new empty GPT disklabel

    - LBA alignment, it necessary to use the same things we use for MBR;
      partitions has to be aligned according to I/O limits (sector
      size). [Important!]

    - move list_table() functions to fdisk_label drive struct

    - remove 'disklabel' from fdisk.c at all and keep fdisk.c
      independent on MBR

    - remove global label-specific variables (e.g. gpt ents[])

    - test GPT (specially 't' command) on big-endian machine
      (EFI UUIDs has been designed during LSD trip...)


less important things:

    - add '<something>' to fdisk menu to print details about selected
      partition (uuid, type uuid, type name, name, etc...)

    - add '<something>' to menu to print details about the partition
      table (header, backup header, locations, number of allocated
      entries, used entries, offset of entry table and offset and size
      of data area, etc.)

All should be implemented by drive specific functions, without
exceptions, fdisk.c has to be simple and readable :-)

Note I did not applied the man page yet. I think we can do that
later when the code will be stable.

> Note that when adding libblkid support for probing, some of the local probing functions will go.

 Yes, but this is not so important for now. We have to clean up before
 we start to implement new things.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
