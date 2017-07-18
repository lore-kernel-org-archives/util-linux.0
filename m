Return-Path: mark.tinguely@hpe.com
Subject: Re: [PATCH] libblkid: add HPE extended-XFS to known filesystems
To: Karel Zak <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>
References: <012d19cf-cf77-fe9a-29c5-98ca42c3d377@hpe.com>
 <20170718083514.alsfyb4k2ntxmtzd@ws.net.home>
From: Mark Tinguely <mark.tinguely@hpe.com>
Message-ID: <56b0e75c-1317-2f82-8cd4-626f394409ef@hpe.com>
Date: Tue, 18 Jul 2017 07:56:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170718083514.alsfyb4k2ntxmtzd@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 07/18/2017 03:35 AM, Karel Zak wrote:
> On Fri, Jun 30, 2017 at 09:30:39AM -0500, Mark Tinguely wrote:
>> From: Mark Tinguely <mark.tinguely@hpe.com>
>> The HPE (formerly SGI) enhanced XFS has changed its magic
> Is it already supported by Linux kernel? I have problem google
> anything about EXFS.
XFS was written by SGI and SGI open sourced a version of it. EXFS is the 
SGI version of XFS.
HPE bought SGI in Nov 2016. With the purchase of SGI, HPE now owns the 
the XFS trademark.
This patch renames the EXFS magic so our customers can have a XFS root 
filesystem and EXFS filesystems.
>
>> version number to allow the use of EXFS and community XFS
>> filesystems at the same time.
> Unfortunately the patch uses the same magic string for EXFS log
> (0xFEEDbabe) as XFS log. The result is that libblkid detects EXFS log
> on all XFS images.  (try "cd tests; ./run.sh blkid")

We know that the log has the same numbers.
>
>> +#define EXLOG_HEADER_MAGIC_NUM 0xFEEDbabe
>   ...
>
>> +/* exlog record header will be in some sector in the first 256k */
>> +static int probe_exfs_log(blkid_probe pr,
>> +		const struct blkid_idmag *mag __attribute__((__unused__)))
>> +{
>> +	int i;
>> +	struct exlog_rec_header *rhead;
>> +	unsigned char *buf;
>> +
>> +	buf = blkid_probe_get_buffer(pr, 0, 256*1024);
>> +	if (!buf)
>> +		return errno ? -errno : 1;
>> +
>> +	if (memcmp(buf, "EXFS", 4) == 0)
>> +		return 1;			/* this is regular EXFS, ignore */
>> +
>> +	/* check the first 512 512-byte sectors */
>> +	for (i = 0; i < 512; i++) {
>> +		rhead = (struct exlog_rec_header *)&buf[i*512];
>> +
>> +		if (exlog_valid_rec_header(rhead)) {
>> +			blkid_probe_set_uuid_as(pr, rhead->h_uuid, "LOGUUID");
>> +
>> +			if (blkid_probe_set_magic(pr, i * 512,
>> +						sizeof(rhead->h_magicno),
>> +						(unsigned char *) &rhead->h_magicno))
>> +				return 1;
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return 1;
>> +}
> If there is no difference between XFS Log and EXFS Log than we cannot add
> probe_exfs_log().
>
>      Karel
>
>
Intentionally, there is no difference XFS and EXFS v4 logs.

--Mark Tinguely
