Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:56808 "EHLO
	resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537AbaLIVRH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Dec 2014 16:17:07 -0500
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id sB9LH5xr014330
	for <util-linux@vger.kernel.org>; Tue, 9 Dec 2014 16:17:05 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: util-linux@vger.kernel.org
Subject: Re: fdisk units size & disk manufacturers buying the standard
In-Reply-To: <54862BFC.8070402@earthlink.net> (mrmazda@earthlink.net)
Date: Tue, 09 Dec 2014 16:17:05 -0500
Message-ID: <87d27s8qwe.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Felix Miata <mrmazda@earthlink.net> writes:
> Whether SI got the Bs & bs right I won't get into, but they did get logically
> correct exposing the hijacking of the centuries old decimal concepts
> represented by K, M, G, T, et al, and interjecting "i" to delineate a
> considerably less ambiguous powers of two counting system.

Indeed, and the most important thing is to make sure that all the
utilities use GB vs. GiB correctly.  Clear communication neutralizes
many other mistakes.

Dale
