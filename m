Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58968 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760693AbbA3VeV (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Jan 2015 16:34:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E019220915
	for <util-linux@vger.kernel.org>; Fri, 30 Jan 2015 16:34:20 -0500 (EST)
Message-Id: <1422653660.1205461.221145325.78FCAC9D@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: deleting an extended partition with cfdisk leaves its contained
 partitions in existence
Date: Fri, 30 Jan 2015 22:34:20 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On my disk, /dev/sda4 is an extended partition that contains four
partitions.  If I use cfdisk and delete /dev/sda4, the contained
four partitions also seem to have been deleted.  But after an
extended partition sda4 has been recreated, trying to create a
new partition in its free space results in a red message on the
bottombar: "Partition 5 is already defined.  Delete it before
re-adding it."  But there is no way to delete partition 5 other
than restarting cfdisk.

Deleting an extended partition should either delete also all the
partitions it contains, or it should refuse the deletion before all
the contained partitions have been deleted.  Probably the first
option is the most user-friendly.

Benno

-- 
http://www.fastmail.com - A no graphics, no pop-ups email service

