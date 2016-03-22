Return-Path: util-linux-owner@vger.kernel.org
Received: from relay04.stack.nl ([131.155.140.107]:57375 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752592AbcCVMZN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 08:25:13 -0400
Received: from toad.stack.nl (toad.stack.nl [IPv6:2001:610:1108:5010::135])
	by mx1.stack.nl (Postfix) with ESMTP id 4F5BAB80F1
	for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 13:17:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by toad.stack.nl (Postfix) with ESMTP id 7EB7273016
	for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 13:17:42 +0100 (CET)
Date: Tue, 22 Mar 2016 13:17:42 +0100 (CET)
From: Serge van den Boom <serge+util-linux@vdboom.org>
To: util-linux@vger.kernel.org
Subject: Subject: Multiple issues with partx
Message-ID: <alpine.BSF.2.00.1603151918560.60883@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I have encounted a few issues with 'partx'.

1. 'partx --nr 1:' does not work.
If you leave the upper range empty, partx uses 0 instead. So instead
of the list of all partitions -- which you should get according to
the manual -- you get an error:

    partx: specified range <1:0> does not make sense

Changing the default to -1 in parse_range() would fix this, but see
issue #2 below.
Also note that while *upper is set to 'def' in parse_range:

    *upper = *lower = def;

this value is not actually used, because a few lines below there is:

    if (*end == ':' && !*(end + 1))     /* <M:> */
        *upper = 0;

If the possibility to override the default value is desired, it would
imho be best to have separate default values for the lower and upper
range.


2. 'partx --nr <M:N>' does not take empty partition table entries into
    account when using negative indexes.

I have created a test file with a partition table with the first and
third entry used, but the second entry open:

    $ partx testfile
    NR START   END SECTORS SIZE NAME UUID
    1  2048 10000    7953 3.9M      4fafc399-01
    3 10001 20479   10479 5.1M      4fafc399-03

One might expect that 'partx --nr 1:-1' would list all partitions (i.e.
from the first to the last partition), but this is currently not true in
this case:

    $ partx --nr 1:-1 testfile
    NR START   END SECTORS SIZE NAME UUID
     1  2048 10000    7953 3.9M      4fafc399-01

In fact, 'partx --nr -1:-1' returns no output at all.
This is because negative values are offset against the number of partitions,
which is less than the number of the partition with the highest number.

One approach to solving this would be to offset against the number of
the last partition in the partition table, but this would not work as
expected when the partitions are our of order.

Another approach would be to offset negative numbers against the number
of the partition with the highest partition number.
In the case that there are holes in the partition table, this would not
necessarily return the same number of partitions as would be expected
by looking at the range. e.g. Using the same test file as above, 'partx
--nr -2:-1' would produce only one entry:

    NR START   END SECTORS SIZE NAME UUID
     3 10001 20479   10479 5.1M      4fafc399-03

Yet another approach may be to consider the list of partitions
in the order in which they are normally shown by partx, and consider
negative numbers to be indices offset against the length of the list.
The disadvantage here is that negative numbers don't mean the
same thing as positive numbers; positive numbers refer to partition
numbers, while negative numbers refer to indices in a sorted list.
'partx --nr 1:-1' would then mean 'the partitions in the sorted list of
partitions, starting with the one with number 1, up to the last
partition in the list.

Then there are the options to add a separate option with a different
meaning for negative indices, or to remove the support for negative numbers
altogether.


3. It is not always clear whether a single partition table entry refers
   to the partition table on the block device, or to a partition table
   entry of the block device of which the specified block device is a part.

When the specified block device contains a partition table, that
partition table is shown. When it does not contain a partition table,
but the block device is a partition itself, its entry on its parent
block device is shown. When you don't know whether a given block device
contains is a full disk or a partition (because you're calling partx
from a script) special logic would be required. Also, nested partition
tables are theoretically possible, though unusual.

My preferred solution would be to only show the partition table on the
specified block device, unless a partition is explicitly specified.
Perhaps the behaviour could also be modified using added parameters.

As a work-around, something like 'partx --nr 1:65535' may be used if
you are interested in the partitions of the specified block device
itself. 'partx --nr 1:' would avoid the arbitrary upper bound, but does
not work because of issue 1, and 'partx --nr 1:-1' would too, but does
not work because of issue 2.


4. It is possible to specify a partition by the device name of a
   partition on another block device.

The command 'partx /dev/sdb2 /dev/sda' makes no sense, but still
produces output, namely the second partition of /dev/sda.


Regards,

Serge

