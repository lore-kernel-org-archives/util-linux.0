Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36089 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbbALJ7G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Jan 2015 04:59:06 -0500
Date: Mon, 12 Jan 2015 10:59:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: partx does not seem able to combine showing with updating
Message-ID: <20150112095902.GB20899@x2.net.home>
References: <1421011500.3996453.212533857.5E69F442@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421011500.3996453.212533857.5E69F442@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 11, 2015 at 10:25:00PM +0100, Benno Schulenberg wrote:
> 
> # ./partx --update --pairs -n 2 -o SIZE /dev/sda
> SIZE="14.9G"
> 
> # ./partx --pairs --update -n 2 -o SIZE /dev/sda
> 
> 
> # ./partx --verbose --update --pairs -n 2 -o SIZE /dev/sda
> partition: none, disk: /dev/sda, lower: 2, upper: 2
> /dev/sda: partition table type 'dos' detected
> SIZE="14.9G"
> 
> # ./partx --verbose --pairs --update -n 2 -o SIZE /dev/sda
> partition: none, disk: /dev/sda, lower: 2, upper: 2
> /dev/sda: partition table type 'dos' detected
> /dev/sda: partition #2 added
> 
> 
> In my opinion the output should be the same in both cases,
> either both updating and showing the partition, or saying
> that the two options cannot be combined.

 Yes, --update is missing in "mutually exclusive" list. Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
