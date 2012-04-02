Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:49490 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751595Ab2DBNPm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Apr 2012 09:15:42 -0400
Received: from homiemail-a38.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTP id 0867310AFB2
	for <util-linux@vger.kernel.org>; Mon,  2 Apr 2012 06:15:40 -0700 (PDT)
Received: from [192.168.1.35] (123.Red-79-146-221.dynamicIP.rima-tde.net [79.146.221.123])
	(Authenticated sender: smtp@zesaurus.cl)
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTPA id 4587A10AFB1
	for <util-linux@vger.kernel.org>; Mon,  2 Apr 2012 06:15:39 -0700 (PDT)
Subject: fdisk and Google SoC 2012
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: util-linux <util-linux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-mnwsxCi5XTr/nN6VASKv"
Date: Mon, 02 Apr 2012 15:15:35 +0200
Message-ID: <1333372535.2552.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-mnwsxCi5XTr/nN6VASKv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

The fixing fdisk item in our TODO list has been there as long as I can
remember. We have been working on adding this to the Google Summer of
Code 2012 program with openSUSE thanks to Petr. I am applying to do
this, and wanted to share some details with the util-linux community,
since in the end, any results will be added here.

I am attaching some details of the application, any comments are
welcome.

Thanks,
Davidlohr

--=-mnwsxCi5XTr/nN6VASKv
Content-Disposition: attachment; filename="gsoc-proposition-fdisk.txt"
Content-Type: text/plain; name="gsoc-proposition-fdisk.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Google Summer of Code 2012, Open SuSE - fdisk - student submission.

Project: Redesign fdisk to be more extensible and implement GPT support

Project Proposition
====================

- Introduction: The fdisk tool is perhaps the most recognized disk partitioner in the world, as it has historically been present in all Unix flavors (including GNU/Linux) and Windows operating systems. While this tool has proven useful and stable for its Linux variant, it as been subject to intense patching along its 20 years of existance, and today it is a product of multiple authors, coding styles and concepts. Because of this, extending fdisk to keep up with modern day computing is hard, time consuming and error prone. For these reasons, it is paramount to order and cleanup fdisk, as it as been done with other tools in the util-linux package and update it to Today's standards so it can continue to compete with other, similiar programs, like GNU parted.

Adding support for GUID partition tables (GPT) comes easier after dealing with the task previously described, and it is very important for fdisk to have it (it currently *only* detects the table) since more and more users, including myself, are running systems with EFI. 

- Specific Goals: Redesign the fdisk program and add GPT support.

- Implementation/Timeline: The Google Summer of Code program requires development/student-mentor signup to start April 20th, and development ends by August  20th. This totals 4 months, or 16 weeks. Below is a timeline estimate, describing what can be done, in week units. As stated above, this project can be devided into two tasks: 1- redesign fdisk and 2- implement GPT, this must be reflected in that order in the timeline.

* week 1: Design and implement most important regression tests - this is paramount for a popular tool like this. We cannot break fdisk in any way, users will go crazy if we mess up/corrupt any of their data, just as if a filesystem did something it shouldn't. Regression tests will make future changes easier to verify and defend.

* week 2-3: Look at, and remove, obsolete code, like CHS (cylinder, head, sector) - it seems that sfdisk is the most common user of this addressing technique. Note that GPT doesn't know anything about CHS anyway.

* week 4-5: Create an abstraction for the user interfaces, so that each of the tools shipped with fdisk just call these interfaces. For cfdisk, which is all about ncurses, it can at least use this _API_ for the dialog texts.

* week 6-8: Make use of libblkid for partiton table detection. This library currently handles mac, aix, gpt, dos, bsd, sgi and sun, unixware, minix and dos partition tables, so by doing this we gain in code reuse, stability, simplification and standarization. The same concept was applied when reimplementing partx(8) from scratch.

* week 9: Look into designing how GPT is to be supported by fdisk; the gfdisk/libparted code can be used as an initial example on how to do this - including hybrid MBRs.

* week 10 - 15: implement GPT support (also add regression test for GPT).

* week 16: Final review and deal with any pending issues.

--Notes (i) Any global function, used across all fdisk family tools, can be commented with GtkDoc/Doxygen, or similar for automatic documentation generation in multiple formats - like what libmont, libuuid and libblkid use.
 (ii) Datatype standardization can be done while writing code for the tasks described above - perhaps a final "review" can include a more thorough look into this.

- Benefits: For redesigning fdisk, hackers and developers will suffer less when dealing with the code and having proper documentation. Maintainers can easily detect any regression bugs with regression tests.
Furthermore, for GPT support, all users can benefit from being able to handle partitions for this partition table, which is being widely adopted by the industry, like Apple products.

- Canveats: modifying large amounts of fdisk code is dangerous for end users as the risk of breaking something increases. Modifications, specially delicate ones, must be verified by the student, mentor and hopefully, upstream maintainer. It might also be wise to do this incrementally, for example go submitting patches to util-linux as work goes by, and not only at the end, this further reduces the risk of regression bugs.

- Technical Details: The first part of the project, redesigning fdisk, is mostly reusing what is already available - fdisk code and libblkid for partition table parsing. For example, a listing function, that could be used to replace the current fdisk list_table(), could simply be replaced with:

int nparts = blkid_partlist_numof_partitions(ls);              
for(i = 0; i < nparts; i++) {
blkid_partition par = blkid_partlist_get_partition(ls, i);

int n = blkid_partition_get_partno(par);

uintmax_t start, size;

start = blkid_partition_get_start(par);
size =  blkid_partition_get_size(par);

printf(_("#%2d: %9ju-%9ju (%9ju sectors, %6ju MB)\n"),
      n, start, start + size -1,
      size, (size << 9) / 1000000);

A nice user interface enhancement for fdisk could be to use libreadline for autocompletion and other nice features tools like gdb offer. This perhaps could be implemented in the dialog interfaces mentioned above.

Because it is a new feature, I believe that the more challenging aspect of this project is implementing GPT, however the task is much simplified by being able to see how other partitioners do it and online specs, such as http://developer.apple.com/library/mac/#technotes/tn2166/_index.html 



--=-mnwsxCi5XTr/nN6VASKv--

