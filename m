Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:41987 "EHLO
	resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbbGOApw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jul 2015 20:45:52 -0400
From: worley@alum.mit.edu (Dale R. Worley)
To: Scott Moser <smoser@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: GPT writing of unknown partition uuids
In-Reply-To: <alpine.DEB.2.02.1507141610310.21273@brickies> (smoser@ubuntu.com)
Date: Tue, 14 Jul 2015 20:37:38 -0400
Message-ID: <87mvyymf1p.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Scott Moser <smoser@ubuntu.com> writes:
> If sfdisk does not know the uuid provided, it silently falls back to
> 0FC63DAF-8483-4772-8E79-3D69D8477DE4 (Linux filesystem).
> 
> It seems like if the user provided you with a GUID, sfdisk should trust
> them, or at very least exit failure if it refuses to use the provided
> GUID.

Ugh, you're right!  Silent disobedience is pernicious.

Dale
