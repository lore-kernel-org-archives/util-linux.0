Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45982 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753567AbbAFUst (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Jan 2015 15:48:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A5E2520C3E
	for <util-linux@vger.kernel.org>; Tue,  6 Jan 2015 15:48:48 -0500 (EST)
Message-Id: <1420577328.1786767.210387085.321E0759@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Antonio Ceballos <aceballos@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAO7R9g8aGM48RzU-ed-cYyAdUEPbX7B4QSsVTdLx90poPtKwhQ@mail.gmail.com>
References: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
 <1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com>
 <CAO7R9g8aGM48RzU-ed-cYyAdUEPbX7B4QSsVTdLx90poPtKwhQ@mail.gmail.com>
Subject: Re: questions on util-linux translation
Date: Tue, 06 Jan 2015 21:48:48 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Jan 6, 2015, at 11:34, Antonio Ceballos wrote:
> 2. My first suggestion is "too neutral" for that context. Your
> suggestion probably sounds better. I presume that something
> more explicit but longer is worse, such as:
> 
> "partition #7 cannot be removed, as it doesn't exist"

Yeah, that is rather oververbose.  The message is not a contextless
error message, but gets produced only when --verbose is used.  The
previously mentioned example of deleting partitions 5 to 9 (with 7
not existing), the command would be:

partx --delete --verbose -n 5:9 /dev/sda

and it currently would print the following progress messages:

dev/sda: partition #5 removed
dev/sda: partition #6 removed
dev/sda: partition #7 already doesn't exist
dev/sda: partition #8 removed
dev/sda: partition #9 removed

In fact I think the message for #7 is quite good,
and I don't think that my proposal is any better:

dev/sda: partition #5 removed
dev/sda: partition #6 removed
dev/sda: skipping nonexistent partition #7
dev/sda: partition #8 removed
dev/sda: partition #9 removed

Benno

-- 
http://www.fastmail.com - Or how I learned to stop worrying and
                          love email again

