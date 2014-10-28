Return-Path: martin.petersen@oracle.com
To: Karel Zak <kzak@redhat.com>
Cc: dE <de.techno@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <544E923E.6050406@gmail.com> <20141028075308.GI10134@x2.net.home>
Date: Tue, 28 Oct 2014 08:38:18 -0400
In-Reply-To: <20141028075308.GI10134@x2.net.home> (Karel Zak's message of
	"Tue, 28 Oct 2014 08:53:08 +0100")
Message-ID: <yq138a8pdxh.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <util-linux.vger.kernel.org>

>>>>> "Karel" == Karel Zak <kzak@redhat.com> writes:

Karel> This is standard behavior for all modern partitioning tools.

Karel> the goal is to start the first partition on offset which is the
Karel> most portable and the most useful on all possible disk
Karel> configurations.

Not only that. It was an explicit request from IDEMA. The disk drive and
RAID vendors asked all operating system vendors to ensure 1MB alignment
by default.

-- 
Martin K. Petersen	Oracle Linux Engineering
