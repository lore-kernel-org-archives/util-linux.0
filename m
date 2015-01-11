Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39436 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999AbbAKVZC (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 16:25:02 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 19ADF2043D
	for <util-linux@vger.kernel.org>; Sun, 11 Jan 2015 16:25:01 -0500 (EST)
Message-Id: <1421011500.3996453.212533857.5E69F442@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: partx does not seem able to combine showing with updating
Date: Sun, 11 Jan 2015 22:25:00 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


# ./partx --update --pairs -n 2 -o SIZE /dev/sda
SIZE="14.9G"

# ./partx --pairs --update -n 2 -o SIZE /dev/sda


# ./partx --verbose --update --pairs -n 2 -o SIZE /dev/sda
partition: none, disk: /dev/sda, lower: 2, upper: 2
/dev/sda: partition table type 'dos' detected
SIZE="14.9G"

# ./partx --verbose --pairs --update -n 2 -o SIZE /dev/sda
partition: none, disk: /dev/sda, lower: 2, upper: 2
/dev/sda: partition table type 'dos' detected
/dev/sda: partition #2 added


In my opinion the output should be the same in both cases,
either both updating and showing the partition, or saying
that the two options cannot be combined.

Benno

-- 
http://www.fastmail.com - The way an email service should be

