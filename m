Return-Path: martin.petersen@oracle.com
To: Tom Yan <tom.ty89@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: optimal io size / custom alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
	<20150615133154.GV1992@ws.net.home>
	<CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
Date: Tue, 16 Jun 2015 13:08:41 -0400
In-Reply-To: <CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
	(Tom Yan's message of "Tue, 16 Jun 2015 13:20:37 +0800")
Message-ID: <yq1zj3zfuna.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <util-linux.vger.kernel.org>

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

Tom> From the adapter/drive I have, it is the same as the "Maximum
Tom> transfer length" and they seem to be simply limits of SCSI "WRITE
Tom> SAME (10/16)" command:

The two values have nothing to do with each other. They just happen to
be the same in your case (65535 is the maximum block count for the WRITE
SAME(10) command).

Tom> [tom@localhost ~]$ sudo sg_inq -p 0xb0 /dev/sdb VPD INQUIRY: Block
Tom> limits page (SBC) Maximum compare and write length: 0 blocks
Tom> Optimal transfer length granularity: 1 blocks Maximum transfer
Tom> length: 65535 blocks Optimal transfer length: 65535 blocks

Your device sets the transfer length granularity to 1 logical block and
the optimal transfer length to 65535 logical blocks. If it then reports
a 4096-byte physical block size in response to READ CAPACITY(16) then
it's clearly on crack.

There's only so much we can do about devices that report garbage.

Also, the kernel only reports things. It is up to Karel to decide
whether to sanity check the values before he uses them.

I would probably err on the side of trusting the physical block size
reporting more than anything seeded from the Block Limits VPD. And in
this case, assuming the alignment offset is reported to be 0, I guess
one could entertain aligning to the nearest 4K boundary. But on the
other hand it'll quickly get hairy to have to maintain this kind of
heuristics.

The best fix, of course, is to complain to the manufacturer of your
broken widget and hope for a firmware upgrade. Failing that, adjust your
partitions manually.

Tom> The thing is, why any io/transfer size/length should be considered
Tom> when it comes to partition alignment? From what I understand,
Tom> partition alignment is only to make sure partition starts at
Tom> physical boundaries of the disk because of the mismatch between
Tom> logicial sector (512 bytes) and physical sectors (4096 bytes) or
Tom> pages/erase blocks of SSDs.

For RAID it makes a big difference to ensure the partition is aligned on
a stripe boundary.

-- 
Martin K. Petersen	Oracle Linux Engineering
